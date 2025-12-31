from rest_framework.routers import DefaultRouter
from .views import UserViewSet

router = DefaultRouter()
# Register as 'users' so the URL becomes /api/users/ (when included under /api/)
router.register(r'users', UserViewSet, basename='users_direct')

urlpatterns = router.urls
