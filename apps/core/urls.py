from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import SiteSettingsView, ResetSettingsView, HeroImageViewSet, ConfigView

router = DefaultRouter()
router.register(r'hero-images', HeroImageViewSet)

urlpatterns = [
    path('settings/', SiteSettingsView.as_view(), name='site-settings'),
    path('settings/reset/', ResetSettingsView.as_view(), name='site-settings-reset'),
    path('config/', ConfigView.as_view(), name='site-config'),
    path('', include(router.urls)),
]
