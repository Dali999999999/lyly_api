from rest_framework import viewsets, status, generics, parsers, permissions
from rest_framework.response import Response
from rest_framework.decorators import action
from .models import SiteSettings, HeroImage
from .serializers import SiteSettingsSerializer, HeroImageSerializer
from rest_framework.permissions import IsAuthenticatedOrReadOnly, IsAdminUser

class SiteSettingsView(generics.RetrieveUpdateAPIView):
    serializer_class = SiteSettingsSerializer
    permission_classes = [IsAuthenticatedOrReadOnly]

    def get_object(self):
        return SiteSettings.get_settings()
    
    def get_permissions(self):
        if self.request.method in ['PUT', 'PATCH']:
            return [IsAdminUser()]
        return [IsAuthenticatedOrReadOnly()]

class ResetSettingsView(generics.GenericAPIView):
    permission_classes = [IsAdminUser]
    serializer_class = SiteSettingsSerializer

    def post(self, request, *args, **kwargs):
        settings = SiteSettings.get_settings()
        settings.primary_color = "#c5874a"
        settings.secondary_color = "#b96c3d"
        settings.background_color = "#fbf7f0"
        settings.save()
        return Response(self.get_serializer(settings).data)

class HeroImageViewSet(viewsets.ModelViewSet):
    queryset = HeroImage.objects.all()
    serializer_class = HeroImageSerializer
    permission_classes = [IsAdminUser]
    parser_classes = (parsers.MultiPartParser, parsers.FormParser)

    def perform_create(self, serializer):
        settings = SiteSettings.get_settings()
        serializer.save(settings=settings)

class ConfigView(generics.GenericAPIView):
    permission_classes = [permissions.AllowAny]

    def get(self, request):
        from django.conf import settings
        return Response({
            'kkiapay_public_key': getattr(settings, 'KKIAPAY_PUBLIC_KEY', None)
        })
