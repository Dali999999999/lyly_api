from django.db import models
from django.utils import timezone

class SoftDeleteManager(models.Manager):
    def get_queryset(self):
        return super().get_queryset().filter(is_deleted=False)
    
    def all_with_deleted(self):
        return super().get_queryset()
    
    def deleted(self):
        return super().get_queryset().filter(is_deleted=True)

class SoftDeleteModel(models.Model):
    is_deleted = models.BooleanField(default=False)
    deleted_at = models.DateTimeField(null=True, blank=True)

    objects = SoftDeleteManager()
    all_objects = models.Manager() # Default manager to access everything if needed

    class Meta:
        abstract = True

    def delete(self, using=None, keep_parents=False):
        self.is_deleted = True
        self.deleted_at = timezone.now()
        self.save()

    def restore(self):
        self.is_deleted = False
        self.deleted_at = None
        self.save()

    def hard_delete(self):
        super().delete()

class SiteSettings(models.Model):
    shop_name = models.CharField(max_length=255, default="Lyly's Bakery")
    contact_email = models.EmailField(default="contact@lylys.com")
    
    # Theme Colors
    primary_color = models.CharField(max_length=7, default="#c5874a") # bakery-500
    secondary_color = models.CharField(max_length=7, default="#b96c3d") # bakery-600
    background_color = models.CharField(max_length=7, default="#fbf7f0") # bakery-50
    
    # Singleton pattern enforcement
    def save(self, *args, **kwargs):
        if not self.pk and SiteSettings.objects.exists():
            # If you try to save a new instance but one exists, update the existing one 
            # (Strict singleton would raise error, but this is friendlier for some flows)
            return SiteSettings.objects.first()
        return super(SiteSettings, self).save(*args, **kwargs)

    @classmethod
    def get_settings(cls):
        settings, created = cls.objects.get_or_create(id=1)
        return settings

    def __str__(self):
        return self.shop_name

class HeroImage(models.Model):
    settings = models.ForeignKey(SiteSettings, related_name='hero_images', on_delete=models.CASCADE)
    image = models.ImageField(upload_to='hero_images/')
    order = models.PositiveIntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['order', 'created_at']

    def __str__(self):
        return f"Hero Image {self.order} for {self.settings.shop_name}"
