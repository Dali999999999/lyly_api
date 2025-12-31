from rest_framework import viewsets, permissions
from .models import DeliveryZone
from .serializers import DeliveryZoneSerializer

class DeliveryZoneViewSet(viewsets.ModelViewSet):
    queryset = DeliveryZone.objects.all()
    serializer_class = DeliveryZoneSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly] # Admin write, everyone read (needed for checkout)
