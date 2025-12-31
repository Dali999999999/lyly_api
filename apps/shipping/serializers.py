from rest_framework import serializers
from .models import DeliveryZone

class DeliveryZoneSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliveryZone
        fields = ['id', 'name', 'city', 'price', 'estimated_time', 'is_active']
