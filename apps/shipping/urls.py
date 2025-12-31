from rest_framework.routers import DefaultRouter
from .views import DeliveryZoneViewSet

router = DefaultRouter()
router.register(r'zones', DeliveryZoneViewSet)

urlpatterns = router.urls
