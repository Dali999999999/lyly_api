from django.db import models

class DeliveryZone(models.Model):
    name = models.CharField(max_length=100, help_text="Nom de la zone (ex: Centre-ville, Calavi, etc.)")
    city = models.CharField(max_length=100, default="Cotonou")
    price = models.PositiveIntegerField(help_text="Prix de la livraison en FCFA")
    estimated_time = models.CharField(max_length=50, blank=True, null=True, help_text="Temps estimé (ex: 20-30 min)")
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.city} - {self.name} ({self.price} FCFA)"

    class Meta:
        ordering = ['city', 'price']
