from rest_framework import viewsets, permissions, filters
from rest_framework.parsers import MultiPartParser, FormParser, JSONParser
from django_filters.rest_framework import DjangoFilterBackend
from .models import Category, Product
from .serializers import CategorySerializer, ProductSerializer

class IsAdminOrReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):
        if request.method in permissions.SAFE_METHODS:
            return True
        return request.user and request.user.is_staff

from django.db.models import Count, Q

from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status

class CategoryViewSet(viewsets.ModelViewSet):
    # Default queryset (modified in get_queryset)
    queryset = Category.objects.filter(is_deleted=False)
    serializer_class = CategorySerializer
    permission_classes = [IsAdminOrReadOnly]
    parser_classes = (MultiPartParser, FormParser, JSONParser)
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['is_active']
    
    def get_queryset(self):
        queryset = Category.objects.filter(is_deleted=False).annotate(
            product_count=Count('products', filter=Q(products__is_deleted=False))
        )
        
        # Admin Mode: Return all (Active + Inactive)
        if self.request.user.is_staff and self.request.query_params.get('mode') == 'admin':
            return queryset
            
        # Public Mode (Default): Return only Active
        return queryset.filter(is_active=True)

    @action(detail=False, methods=['get'], permission_classes=[permissions.IsAdminUser])
    def trash(self, request):
        queryset = Category.objects.all_with_deleted().filter(is_deleted=True)
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['get'], permission_classes=[permissions.IsAdminUser])
    def trash_products(self, request, pk=None):
        try:
            category = Category.objects.all_with_deleted().get(pk=pk)
            # Find products that are deleted and belong to this category
            # Optimize: Prefetch images and select category to avoid N+1
            products = Product.objects.all_with_deleted().filter(
                category=category, 
                is_deleted=True
            ).select_related('category').prefetch_related('images')
            serializer = ProductSerializer(products, many=True) 
            return Response(serializer.data)
        except Category.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

    @action(detail=True, methods=['post'], permission_classes=[permissions.IsAdminUser])
    def restore(self, request, pk=None):
        try:
            category = Category.objects.all_with_deleted().get(pk=pk)
            category.restore()

            # Handle Product Restoration
            restore_all = request.data.get('restore_all_products', False)
            product_ids = request.data.get('product_ids', [])

            if restore_all:
                Product.objects.all_with_deleted().filter(category=category, is_deleted=True).update(is_deleted=False, deleted_at=None)
            elif product_ids:
                Product.objects.all_with_deleted().filter(category=category, id__in=product_ids).update(is_deleted=False, deleted_at=None)

            return Response(status=status.HTTP_200_OK)
        except Category.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

class ProductViewSet(viewsets.ModelViewSet):
    queryset = Product.objects.filter(is_active=True)
    serializer_class = ProductSerializer
    permission_classes = [IsAdminOrReadOnly]
    parser_classes = (MultiPartParser, FormParser, JSONParser)
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['category', 'is_featured', 'is_new', 'is_active']
    search_fields = ['name', 'description']
    ordering_fields = ['price', 'created_at']

    def get_queryset(self):
        # Optimization: Fetch category and images in the same query
        queryset = Product.objects.select_related('category').prefetch_related('images')
        
        # Admin Mode: Return all (Active + Inactive)
        if self.request.user.is_staff and self.request.query_params.get('mode') == 'admin':
            return queryset.filter(is_deleted=False)

        # Public Mode (Default): Return only Active
        # Also ensure category is active
        return queryset.filter(is_active=True, is_deleted=False, category__is_active=True)

    def perform_destroy(self, instance):
        instance.delete() # Uses SoftDeleteModel.delete()

    @action(detail=False, methods=['get'], permission_classes=[permissions.IsAdminUser])
    def trash(self, request):
        queryset = Product.objects.all_with_deleted().filter(is_deleted=True).select_related('category').prefetch_related('images')
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    @action(detail=True, methods=['post'], permission_classes=[permissions.IsAdminUser])
    def restore(self, request, pk=None):
        try:
            product = Product.objects.all_with_deleted().get(pk=pk)
            
            # Constraint: Cannot restore product if category is deleted
            if product.category.is_deleted:
                return Response(
                    {"detail": "Impossible de restaurer le produit car sa catégorie est supprimée."}, 
                    status=status.HTTP_400_BAD_REQUEST
                )

            product.restore()
            return Response(status=status.HTTP_200_OK)
        except Product.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)
