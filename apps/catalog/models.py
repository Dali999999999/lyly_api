from django.db import models
from django.utils.text import slugify
from apps.core.models import SoftDeleteModel

class Category(SoftDeleteModel):
    name = models.CharField(max_length=100)
    slug = models.SlugField(unique=True, blank=True)
    image = models.ImageField(upload_to='categories/', null=True, blank=True)
    description = models.TextField(blank=True)
    is_active = models.BooleanField(default=True)

    class Meta:
        verbose_name_plural = "Categories"

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def delete(self, using=None, keep_parents=False):
        # Soft delete all related products
        for product in self.products.all():
            product.delete()
        super().delete(using, keep_parents)

    def __str__(self):
        return self.name

class Product(SoftDeleteModel):
    category = models.ForeignKey(Category, related_name='products', on_delete=models.CASCADE)
    name = models.CharField(max_length=200)
    slug = models.SlugField(unique=True, blank=True)
    description = models.TextField()
    price = models.DecimalField(max_digits=10, decimal_places=2, db_index=True)
    stock = models.PositiveIntegerField(default=0)
    
    # Details from frontend
    ingredients = models.TextField(blank=True, help_text="Comma separated list")
    calories = models.IntegerField(null=True, blank=True)
    
    is_active = models.BooleanField(default=True) # Used for Draft/Published
    is_featured = models.BooleanField(default=False, db_index=True)
    is_new = models.BooleanField(default=True, db_index=True)
    
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name

class ProductImage(models.Model):
    product = models.ForeignKey(Product, related_name='images', on_delete=models.CASCADE)
    image = models.ImageField(upload_to='products/')
    is_main = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Image for {self.product.name}"
