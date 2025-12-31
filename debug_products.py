import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')
django.setup()

from rest_framework.test import APIRequestFactory, force_authenticate
from rest_framework.request import Request
from django.contrib.auth import get_user_model
from apps.catalog.models import Product, Category
from apps.catalog.views import ProductViewSet, IsAdminOrReadOnly

User = get_user_model()

print("--- Product Diagnostic ---")
products = Product.objects.all_with_deleted()
print(f"Total Products (including deleted): {products.count()}")
for p in products:
    print(f"ID: {p.id}, Name: {p.name}, Active: {p.is_active}, Deleted: {p.is_deleted}, Category: {p.category.name} (Deleted: {p.category.is_deleted})")

print("\n--- Permission Test (IsAdminOrReadOnly) ---")
factory = APIRequestFactory()
request = factory.get('/')
request.user = User.objects.create_user(username='testclient', email='client@test.com', password='password') # Client
view = ProductViewSet()

perm = IsAdminOrReadOnly()

# Test 1: Authenticated Client GET
has_perm = perm.has_permission(request, view)
print(f"Client can GET? {has_perm}")

# Test 2: Anonymous GET
request_anon = factory.get('/')
from django.contrib.auth.models import AnonymousUser
request_anon.user = AnonymousUser()
has_perm_anon = perm.has_permission(request_anon, view)
print(f"Anonymous can GET? {has_perm_anon}")

# Test 3: Client POST
request_post = factory.post('/')
request_post.user = request.user
has_perm_post = perm.has_permission(request_post, view)
print(f"Client can POST? {has_perm_post}")

# Test 4: Admin POST
admin = User.objects.create_superuser(username='testadmin', email='admin@test.com', password='password')
request_admin_post = factory.post('/')
request_admin_post.user = admin 
has_perm_admin = perm.has_permission(request_admin_post, view)
print(f"Admin can POST? {has_perm_admin}")

# Clean up
User.objects.filter(email__in=['client@test.com', 'admin@test.com']).delete()
