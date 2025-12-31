from django.db import models
from django.conf import settings
from apps.catalog.models import Product

from apps.core.models import SoftDeleteModel

class Review(SoftDeleteModel):
    product = models.ForeignKey(Product, related_name='reviews', on_delete=models.CASCADE)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, related_name='reviews', on_delete=models.CASCADE)
    rating = models.PositiveIntegerField(choices=[(i, i) for i in range(1, 6)])
    comment = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created_at']
        unique_together = ('product', 'user')  # One review per product per user? Usually good practice.

    def __str__(self):
        return f"{self.rating}/5 - {self.product.name} by {self.user.email}"
