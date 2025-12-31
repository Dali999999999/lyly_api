
from rest_framework import generics, status, viewsets, filters
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from rest_framework_simplejwt.views import TokenObtainPairView
from django_filters.rest_framework import DjangoFilterBackend
from django.contrib.auth import get_user_model
from django.utils import timezone
from django.core.mail import send_mail
from django.conf import settings
import random
from .serializers import RegisterSerializer, CustomTokenObtainPairSerializer, UserSerializer, PasswordResetRequestSerializer, PasswordResetVerifySerializer, PasswordResetConfirmSerializer, AdminUserSerializer

User = get_user_model()

# ... (omitted parts of file for brevity if not modifying them, but tool replaces contiguous block)
# Wait, I need to look at specific lines for import.
# Using 'multi_replace' or just doing 2 edits. Step 1: Import. Step 2: Use in ViewSet.
# I'll do it in one replace if the distance is huge? 
# Lines 12 (import) and 179 (use) are far apart. 
# I will use multi_replace? NO, I have `replace_file_content` available. I can run 2 tool calls or 1 `multi_replace`.
# The available tool is `replace_file_content`. The instructions say: "If you are making multiple edits across a single file, use the multi_replace_file_content tool instead."
# Okay, I will use multi_replace_file_content.

class RegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    permission_classes = (AllowAny,)
    serializer_class = RegisterSerializer

    def perform_create(self, serializer):
        user = serializer.save()
        # Generate OTP
        otp = str(random.randint(100000, 999999))
        user.otp_code = otp
        user.otp_created_at = timezone.now()
        user.save()
        
        # Send Email
        subject = "Votre code de vérification - Lyly's Bakery"
        message = f"Bonjour {user.first_name},\n\nVotre code de vérification est : {otp}\n\nCe code expire dans 10 minutes."
        try:
            send_mail(subject, message, settings.DEFAULT_FROM_EMAIL, [user.email])
        except Exception as e:
            print(f"Error sending email: {e}")

class VerifyOTPView(generics.GenericAPIView):
    permission_classes = (AllowAny,)
    
    def post(self, request):
        email = request.data.get('email')
        code = request.data.get('code')
        
        try:
            user = User.objects.get(email=email)
            if user.otp_code == code:
                # Basic expiry check (e.g. 10 mins) can be added here
                user.is_email_verified = True
                user.otp_code = None # Clear OTP
                user.save()
                
                # Auto-login: generate tokens
                from rest_framework_simplejwt.tokens import RefreshToken
                refresh = RefreshToken.for_user(user)
                
                
                response = Response({
                    'message': 'Email verified successfully',
                    'user': UserSerializer(user).data
                }, status=status.HTTP_200_OK)
                
                set_jwt_cookies(response, str(refresh.access_token), str(refresh))
                
                return response

            else:
                return Response({'error': 'Invalid OTP'}, status=status.HTTP_400_BAD_REQUEST)
        except User.DoesNotExist:
            return Response({'error': 'User not found'}, status=status.HTTP_404_NOT_FOUND)


def set_jwt_cookies(response, access_token, refresh_token):
    from django.conf import settings
    response.set_cookie(
        key='access_token',
        value=access_token,
        httponly=True,
        secure=not settings.DEBUG,  # Use secure in production
        samesite='None' if not settings.DEBUG else 'Lax', # Allow cross-site in prod
        max_age=3600 # 1 hour
    )
    response.set_cookie(
        key='refresh_token',
        value=refresh_token,
        httponly=True,
        secure=not settings.DEBUG,
        samesite='None' if not settings.DEBUG else 'Lax', # Allow cross-site in prod
        max_age=86400 # 1 day
    )
    return response

class CustomTokenObtainPairView(TokenObtainPairView):
    serializer_class = CustomTokenObtainPairSerializer

    def post(self, request, *args, **kwargs):
        print(f"DEBUG: Login Attempt. Data: {request.data}")
        try:
            response = super().post(request, *args, **kwargs)
        except Exception as e:
            print(f"DEBUG: Login Exception: {e}")
            raise e
            
        print(f"DEBUG: Login Response Status: {response.status_code}")
        if response.status_code != 200:
            print(f"DEBUG: Login Error Data: {response.data}")
            
        if response.status_code == 200:
            access_token = response.data.get('access')
            refresh_token = response.data.get('refresh')
            # remove tokens from body to be clean
            set_jwt_cookies(response, access_token, refresh_token)
            del response.data['access']
            del response.data['refresh']
        return response

class CookieTokenRefreshView(TokenObtainPairView): # inheriting to get post method structure but we need custom logic
    # Actually simpler to use TokenRefreshView logic but adapting for cookies
    def post(self, request, *args, **kwargs):
        from rest_framework_simplejwt.serializers import TokenRefreshSerializer
        from rest_framework_simplejwt.exceptions import InvalidToken, TokenError
        
        refresh_token = request.COOKIES.get('refresh_token')
        
        if not refresh_token:
             return Response({'detail': 'Refresh token not found in cookies'}, status=status.HTTP_401_UNAUTHORIZED)
        
        # Inject into data for serializer
        data = {'refresh': refresh_token}
        
        serializer = TokenRefreshSerializer(data=data)
        
        try:
            serializer.is_valid(raise_exception=True)
        except TokenError as e:
            raise InvalidToken(e.args[0])

        response = Response(serializer.validated_data, status=status.HTTP_200_OK)
        
        # Ideally we should rotate refresh token if configured, 
        # simplejwt rotate returns 'refresh' in validated_data if rotated.
        
        access_token = response.data.get('access')
        new_refresh_token = response.data.get('refresh') # May be None if not rotated
        
        if access_token:
             response.set_cookie(
                key='access_token',
                value=access_token,
                httponly=True,
                secure=not settings.DEBUG,
                samesite='Lax',
                max_age=3600
            )
            
        if new_refresh_token:
             response.set_cookie(
                key='refresh_token',
                value=new_refresh_token,
                httponly=True,
                secure=not settings.DEBUG,
                samesite='Lax',
                max_age=86400
            )
            
        return response

class LogoutView(generics.GenericAPIView):
    permission_classes = (AllowAny,)
    
    def post(self, request):
        response = Response({'message': 'Logged out successfully'}, status=status.HTTP_200_OK)
        response.delete_cookie('access_token')
        response.delete_cookie('refresh_token')
        return response


class UserProfileView(generics.RetrieveUpdateAPIView):
    permission_classes = (IsAuthenticated,)
    serializer_class = UserSerializer

    def get_object(self):
        return self.request.user

class UserViewSet(viewsets.ModelViewSet):
    """
    Admin endpoints to manage users.
    """
    queryset = User.objects.all().order_by('-date_joined')
    serializer_class = AdminUserSerializer
    permission_classes = [IsAdminUser]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['email', 'first_name', 'last_name']
    filterset_fields = ['role', 'is_active', 'is_email_verified']
    ordering_fields = ['date_joined', 'email']

    def perform_create(self, serializer):
        # Admin creating a user: Auto-verify
        password = self.request.data.get('password')
        user = serializer.save(is_email_verified=True, is_active=True)
        if password:
            user.set_password(password)
            user.save()

    def perform_destroy(self, instance):
        # Soft delete
        instance.is_active = False
        instance.save()

class PasswordResetRequestView(generics.GenericAPIView):
    permission_classes = (AllowAny,)
    serializer_class = PasswordResetRequestSerializer

    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        email = serializer.validated_data['email']
        user = User.objects.get(email=email)
        
        # Generate OTP
        otp = str(random.randint(100000, 999999))
        user.otp_code = otp
        user.otp_created_at = timezone.now()
        user.save()
        
        # Send Email
        subject = "Réinitialisation de mot de passe - Lyly's Bakery"
        message = f"Bonjour {user.first_name},\n\nVoici votre code pour réinitialiser votre mot de passe : {otp}\n\nCe code expire dans 10 minutes."
        try:
            send_mail(subject, message, settings.DEFAULT_FROM_EMAIL, [user.email])
        except Exception as e:
            print(f"Error sending email: {e}")
            return Response({'error': 'Erreur lors de l\'envoi de l\'email.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
            
        return Response({'message': 'Code envoyé avec succès.'}, status=status.HTTP_200_OK)

class PasswordResetVerifyView(generics.GenericAPIView):
    permission_classes = (AllowAny,)
    serializer_class = PasswordResetVerifySerializer

    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        email = serializer.validated_data['email']
        code = serializer.validated_data['code']
        
        try:
            user = User.objects.get(email=email)
            # Check OTP validity (e.g. 10 mins window)
            time_diff = timezone.now() - user.otp_created_at if user.otp_created_at else None
            
            if user.otp_code == code and time_diff and time_diff.total_seconds() < 600: # 10 mins
                return Response({'message': 'Code valide.'}, status=status.HTTP_200_OK)
            else:
                return Response({'error': 'Code invalide ou expiré.'}, status=status.HTTP_400_BAD_REQUEST)
        except User.DoesNotExist:
            return Response({'error': 'Utilisateur non trouvé.'}, status=status.HTTP_404_NOT_FOUND)

class PasswordResetConfirmView(generics.GenericAPIView):
    permission_classes = (AllowAny,)
    serializer_class = PasswordResetConfirmSerializer

    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        email = serializer.validated_data['email']
        code = serializer.validated_data['code']
        password = serializer.validated_data['new_password']
        
        try:
            user = User.objects.get(email=email)
            # Re-verify OTP to ensure security at the final step too
            time_diff = timezone.now() - user.otp_created_at if user.otp_created_at else None
            
            if user.otp_code == code and time_diff and time_diff.total_seconds() < 600:
                user.set_password(password)
                user.otp_code = None # Consume OTP
                user.save()
                return Response({'message': 'Mot de passe modifié avec succès.'}, status=status.HTTP_200_OK)
            else:
                return Response({'error': 'Session expirée ou code invalide.'}, status=status.HTTP_400_BAD_REQUEST)
        except User.DoesNotExist:
            return Response({'error': 'Utilisateur non trouvé.'}, status=status.HTTP_404_NOT_FOUND)
class ResendActivationOTPView(generics.GenericAPIView):
    permission_classes = (AllowAny,)
    serializer_class = PasswordResetRequestSerializer # Reuse email validation

    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        email = serializer.validated_data['email']
        try:
            user = User.objects.get(email=email)
            if user.is_email_verified:
                 return Response({'message': 'Compte déjà vérifié.'}, status=status.HTTP_400_BAD_REQUEST)
            
            # Generate OTP
            otp = str(random.randint(100000, 999999))
            user.otp_code = otp
            user.otp_created_at = timezone.now()
            user.save()
            
            # Send Email
            subject = "Nouveau code de vérification - Lyly's Bakery"
            message = f"Bonjour {user.first_name},\n\nVoici votre nouveau code de vérification : {otp}\n\nCe code expire dans 10 minutes."
            try:
                send_mail(subject, message, settings.DEFAULT_FROM_EMAIL, [user.email])
            except Exception as e:
                print(f"Error sending email: {e}")
                return Response({'error': "Erreur d'envoi d'email."}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
                
            return Response({'message': 'Nouveau code envoyé.'}, status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return Response({'error': 'Utilisateur non trouvé.'}, status=status.HTTP_404_NOT_FOUND)
