from django.db import models
from django.conf import settings
from apps.catalog.models import Product

class Order(models.Model):
    STATUS_CHOICES = (
        ('En attente', 'En attente'),
        ('En préparation', 'En préparation'),
        ('Livré', 'Livré'),
        ('Annulé', 'Annulé'),
    )

    PAYMENT_METHOD_CHOICES = (
        ('Carte Bancaire', 'Carte Bancaire'),
        ('Espèces à la livraison', 'Espèces à la livraison'),
        ('Espèces (POS)', 'Espèces (POS)'),
        ('Payer en ligne', 'Payer en ligne'),
        ('Payer à la livraison', 'Payer à la livraison'),
    )

    PAYMENT_STATUS_CHOICES = (
        ('Payé', 'Payé'),
        ('En attente', 'En attente'),
        ('Remboursé', 'Remboursé'),
    )

    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.SET_NULL, null=True, blank=True, related_name='orders')
    full_name = models.CharField(max_length=255)
    email = models.EmailField(blank=True, null=True)
    phone = models.CharField(max_length=50, blank=True, null=True)
    
    # Address structured as JSON or separate fields? 
    # Frontend sends: { street, city, zip }. street might contain GPS.
    # Let's use flexible fields for now or a JSONField if we want strict structure.
    # Given the simplicity, separate fields are fine, or a single text field.
    # Let's go with specific fields matching frontend logic roughly + extra for flexibility.
    shipping_address_json = models.JSONField(default=dict, help_text="Stores street, city, zip, messages, gps")
    
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=50, choices=STATUS_CHOICES, default='En attente', db_index=True)
    
    payment_method = models.CharField(max_length=50, choices=PAYMENT_METHOD_CHOICES, default='Payer en ligne')
    payment_status = models.CharField(max_length=50, choices=PAYMENT_STATUS_CHOICES, default='En attente')
    
    is_viewed = models.BooleanField(default=False)
    
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Order #{self.id} - {self.full_name}"

class OrderItem(models.Model):
    order = models.ForeignKey(Order, related_name='items', on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.SET_NULL, null=True)
    product_name = models.CharField(max_length=255) # Snapshot in case product is deleted
    quantity = models.PositiveIntegerField(default=1)
    price = models.DecimalField(max_digits=10, decimal_places=2) # Snapshot of price

    def __str__(self):
        return f"{self.quantity} x {self.product_name}"
