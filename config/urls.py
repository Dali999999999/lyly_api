from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi

schema_view = get_schema_view(
   openapi.Info(
      title="Lyly's Bakery API",
      default_version='v1',
      description="API documentation for Lyly's Bakery",
   ),
   public=True,
   permission_classes=(permissions.AllowAny,),
)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/auth/', include('apps.accounts.urls')),
    path('api/catalog/', include('apps.catalog.urls')),
    path('api/orders/', include('apps.orders.urls')), # New Orders API
    path('api/reviews/', include('apps.reviews.urls')),
    path('api/', include('apps.coupons.urls')), # Coupons API
    path('api/shipping/', include('apps.shipping.urls')), # Shipping API
    path('api/', include('apps.accounts.urls_users')), # Users API direct access
    path('api/core/', include('apps.core.urls')), # Site Settings & Core

    
    # Swagger Documentation
    path('swagger/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
