from rest_framework import viewsets, permissions, status, filters
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.exceptions import PermissionDenied, ValidationError
from .models import Review
from .serializers import ReviewSerializer
from apps.orders.models import Order

class ReviewViewSet(viewsets.ModelViewSet):
    queryset = Review.objects.all()
    serializer_class = ReviewSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    filter_backends = [filters.OrderingFilter]
    ordering_fields = ['created_at', 'rating']

    def perform_create(self, serializer):
        user = self.request.user
        product = serializer.validated_data['product']
        
        # 1. Check if user already reviewed this product (handled by unique_together but good to check)
        if Review.objects.filter(user=user, product=product).exists():
            raise ValidationError("Vous avez déjà noté ce produit.")

        # 2. Check if user purchased the product and status is 'Livré'
        has_purchased = Order.objects.filter(
            user=user,
            status='Livré',
            items__product=product
        ).exists()

        if not has_purchased:
            raise PermissionDenied("Vous devez avoir acheté et reçu ce produit pour le noter.")

        serializer.save(user=user)

    @action(detail=False, methods=['get'], permission_classes=[permissions.IsAdminUser])
    def trash(self, request):
        """List all soft-deleted reviews"""
        deleted_reviews = Review.objects.deleted()
        serializer = self.get_serializer(deleted_reviews, many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['post'], permission_classes=[permissions.IsAdminUser])
    def restore(self, request, pk=None):
        """Restore a soft-deleted review"""
        try:
            # We need to find it in the deleted objects, or all_objects
            review = Review.all_objects.get(pk=pk)
            review.restore()
            return Response({'status': 'restored'}, status=status.HTTP_200_OK)
        except Review.DoesNotExist:
            return Response({'detail': 'Avis non trouvé'}, status=status.HTTP_404_NOT_FOUND)

    def get_queryset(self):
        # Prevent N+1 queries by selecting related User and Product
        queryset = super().get_queryset().select_related('user', 'product')
        
        product_id = self.request.query_params.get('product', None)
        if product_id is not None:
            queryset = queryset.filter(product_id=product_id)
        return queryset
