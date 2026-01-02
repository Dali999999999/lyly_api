import os
import django
from django.conf import settings

# Setup Django Environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')
django.setup()

from apps.catalog.models import Product

def check_products():
    print("--- Checking Product Status (Local DB = Prod Copy) ---")
    total = Product.objects.all_with_deleted().count()
    active = Product.objects.filter(is_active=True, is_deleted=False).count()
    inactive = Product.objects.filter(is_active=False, is_deleted=False).count()
    deleted = Product.objects.filter(is_deleted=True).count()
    
    print(f"Total Products: {total}")
    print(f"Active (Visible to Public): {active}")
    print(f"Inactive (Hidden): {inactive}")
    print(f"Deleted (Trash): {deleted}")

if __name__ == "__main__":
    check_products()
