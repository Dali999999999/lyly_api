from rest_framework import serializers
from .models import SiteSettings, HeroImage

class HeroImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = HeroImage
        fields = ['id', 'image', 'order']

class SiteSettingsSerializer(serializers.ModelSerializer):
    hero_images = HeroImageSerializer(many=True, read_only=True)

    class Meta:
        model = SiteSettings
        fields = ['shop_name', 'contact_email', 'hero_images', 'primary_color', 'secondary_color', 'background_color']
