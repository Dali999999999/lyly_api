import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')
django.setup()

from apps.catalog.models import Product

print("Activating products...")
updated_count = Product.objects.filter(is_deleted=False).update(is_active=True)
print(f"Successfully activated {updated_count} products.")
