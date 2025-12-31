from rest_framework import viewsets, permissions, status, decorators
from rest_framework.response import Response
from .models import Order
from .serializers import OrderSerializer

class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all().order_by('-created_at')
    serializer_class = OrderSerializer
    
    def get_queryset(self):
        # Optimization: Prefetch items and product images to avoid N+1
        queryset = Order.objects.prefetch_related(
            'items', 
            'items__product', 
            'items__product__images'
        ).order_by('-created_at')

        user = self.request.user
        if user.is_staff:
            return queryset
        if user.is_authenticated:
            return queryset.filter(user=user)
        return Order.objects.none()

    def create(self, request, *args, **kwargs):
        import logging
        logger = logging.getLogger(__name__)
        logger.error(f"DEBUG - Incoming Order Data: {request.data}")
        
        serializer = self.get_serializer(data=request.data)
        if not serializer.is_valid():
            logger.error(f"DEBUG - Validation Errors: {serializer.errors}")
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

    def get_permissions(self):
        if self.action == 'create':
            return [permissions.AllowAny()] # Guests can order
        return [permissions.IsAuthenticated()] # Only auth users can list/retrieve

    def perform_update(self, serializer):
        from rest_framework.exceptions import ValidationError
        from django.db import transaction, models
        
        instance = self.get_object()
        old_status = instance.status
        new_status = serializer.validated_data.get('status', old_status)
        
        STATUS_ORDER = ['En attente', 'En préparation', 'Livré', 'Annulé']
        
        # Validate Transition (Forward Only)
        if old_status in STATUS_ORDER and new_status in STATUS_ORDER:
            old_idx = STATUS_ORDER.index(old_status)
            new_idx = STATUS_ORDER.index(new_status)
            if new_idx < old_idx and old_status != 'Annulé': 
                # Note: User said "quitter livrer pour annuler" (Forward), but "jamais reculer".
                # We enforce index strictly increasing. 'Annulé' is index 3, so it's always forward.
                # Exception: Maybe restoring a cancelled order? 
                # User instructions: "jamais l'inverse". So En attente (0) <- En prép (1) is impossible.
                # Annulé (3) -> En attente (0) impossible.
                raise ValidationError(f"Impossible de passer de '{old_status}' à '{new_status}'. Le statut ne peut qu'avancer.")

        with transaction.atomic():
            # Handle Stock Restoration if cancelling
            # Restore if order was PAID (Online) OR if it was COD (Stock decremented on create)
            should_restore = (
                new_status == 'Annulé' 
                and old_status != 'Annulé' 
                and (instance.payment_status == 'Payé' or instance.payment_method != 'Payer en ligne')
            )
            
            if should_restore:
                for item in instance.items.all():
                    if item.product:
                        # Restore stock
                        item.product.stock = models.F('stock') + item.quantity
                        item.product.save()
            
            
            save_kwargs = {}
            if new_status == 'Livré' and instance.payment_method != 'Payer en ligne':
                save_kwargs['payment_status'] = 'Payé'
            
            serializer.save(**save_kwargs)

        # Send Email Notification
        if old_status != new_status and instance.email:
            from django.core.mail import send_mail
            from django.conf import settings
            from .email_templates import get_status_update_email
            
            try:
                email_data = get_status_update_email(instance, new_status)
                
                send_mail(
                    subject=email_data['subject'],
                    message=email_data['plain_message'],
                    from_email=settings.DEFAULT_FROM_EMAIL,
                    recipient_list=[instance.email],
                    html_message=email_data['html_message'],
                    fail_silently=True,
                )
            except Exception as e:
                print(f"Failed to send status email: {e}")
    @decorators.action(detail=True, methods=['post'])
    def initiate_payment(self, request, pk=None):
        order = self.get_object()
        
        # Get Frontend Origin
        origin = request.META.get('HTTP_ORIGIN', 'http://localhost:5173')
        
        # Construct Local Payment URL
        # The frontend PaymentPage will handle the Kkiapay Widget initialization
        payment_url = f"{origin}/#/payment/{order.id}"
        
        return Response({"payment_url": payment_url}, status=status.HTTP_200_OK)

    @decorators.action(detail=True, methods=['post'])
    def verify_payment(self, request, pk=None):
        import logging
        from django.conf import settings
        from django.db import transaction, models
        from .email_templates import get_order_confirmation_email
        from django.core.mail import send_mail
        from .services import verify_kkiapay_transaction

        logger = logging.getLogger(__name__)

        order = self.get_object()
        transaction_id = request.data.get('transaction_id')
        
        logger.info(f"Verifying payment for Order #{order.id} with Transaction ID: {transaction_id}")

        try:
            # Delegate verification to service
            transaction_data = verify_kkiapay_transaction(transaction_id)
            
            if transaction_data:
                with transaction.atomic():
                    # LOCK the row to prevent race conditions (double decrement)
                    locked_order = Order.objects.select_for_update().get(pk=order.pk)
                    
                    if locked_order.payment_status == 'Payé':
                        logger.info(f"Order #{locked_order.id} already paid.")
                        return Response({"message": "Commande déjà payée"}, status=status.HTTP_200_OK)

                    locked_order.payment_status = 'Payé'
                    locked_order.status = 'En préparation'
                    locked_order.save()

                    for item in locked_order.items.all():
                        if item.product:
                            item.product.refresh_from_db()
                            if item.product.stock < item.quantity:
                                logger.warning(f"Stock insufficient for Product {item.product.id} (Stock: {item.product.stock}, Req: {item.quantity})")
                            item.product.stock = models.F('stock') - item.quantity
                            item.product.save()
                
                # Send Email
                try:
                    if order.email:
                        email_data = get_order_confirmation_email(order)
                        send_mail(
                            subject=email_data['subject'],
                            message=email_data['plain_message'],
                            from_email=settings.DEFAULT_FROM_EMAIL,
                            recipient_list=[order.email],
                            html_message=email_data['html_message'],
                            fail_silently=True
                        )
                except Exception as e:
                    logger.error(f"Email error: {e}")

                return Response({"status": "verified", "order_id": order.id}, status=status.HTTP_200_OK)
            else:
                return Response({"error": "Paiement non valide ou échoué", "details": "Kkiapay returned failed status"}, status=status.HTTP_400_BAD_REQUEST)
                
        except Exception as e:
            logger.exception("Exception during payment verification")
            return Response({"error": f"Erreur vérification: {str(e)}"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    @decorators.action(detail=True, methods=['post'])
    def mark_viewed(self, request, pk=None):
        order = self.get_object()
        if not order.is_viewed:
            order.is_viewed = True
            order.save()
        return Response({'status': 'viewed'}, status=status.HTTP_200_OK)

    @decorators.action(detail=False, methods=['get'])
    def unseen_count(self, request):
        count = Order.objects.filter(is_viewed=False).count()
        return Response({'count': count}, status=status.HTTP_200_OK)
