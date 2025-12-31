from rest_framework import viewsets, status, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import Coupon
from .serializers import CouponSerializer
from django.utils import timezone

class CouponViewSet(viewsets.ModelViewSet):
    queryset = Coupon.objects.all()
    serializer_class = CouponSerializer
    # Client needs VALIDATE endpoint (public).
    # LIST endpoint should be admin only? Yes.
    permission_classes = [permissions.IsAdminUser] 

    @action(detail=False, methods=['post'], permission_classes=[permissions.AllowAny])
    def validate_code(self, request):
        code = request.data.get('code', '').upper()
        try:
            coupon = Coupon.objects.get(code=code)
            if not coupon.is_valid:
                 return Response({
                    "valid": False, 
                    "message": "Ce code promo n'est plus valide (expiré ou limite atteinte)."
                }, status=status.HTTP_200_OK)
            
            return Response({
                "valid": True,
                "code": coupon.code,
                "discount_percent": coupon.discount_percent,
                "message": "Code promo appliqué !"
            })
        except Coupon.DoesNotExist:
            return Response({
                "valid": False,
                "message": "Code promo inexistant."
            }, status=status.HTTP_200_OK)
