from rest_framework import serializers
from .models import Coupon

class CouponSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coupon
        fields = ['id', 'code', 'discount_percent', 'expiry_date', 'is_active', 'usage_count', 'max_uses']

    def validate_code(self, value):
        return value.upper()
