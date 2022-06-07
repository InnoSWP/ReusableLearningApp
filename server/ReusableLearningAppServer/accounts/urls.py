from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

from accounts.views import RegisterView, UserViewSet, SelfUserView

urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', TokenObtainPairView.as_view(), name='login'),
    path('refresh/', TokenRefreshView.as_view(), name='refresh'),
    path('me/', SelfUserView.as_view(), name='me'),
    path('<int:id>/', UserViewSet.as_view({'get': 'retrieve'}), name='users')
]
