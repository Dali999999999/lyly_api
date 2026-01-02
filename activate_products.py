import os
import django
from django.conf import settings

# Setup Django Environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')
django.setup()

from apps.catalog.models import Product

def activate_all_products():
    print("--- Bulk Activating Products ---")
    # Activate everything that isn't in the trash
    count = Product.objects.filter(is_active=False, is_deleted=False).update(is_active=True)
    
    print(f"SUCCESS: Set is_active=True for {count} products.")
    print("All non-deleted products are now visible to the public.")

if __name__ == "__main__":
    activate_all_products()
