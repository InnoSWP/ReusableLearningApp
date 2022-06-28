from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ShopView, ScoreView, InventoryView

router = DefaultRouter()
router.register(r"shop", ShopView, basename="shop")

urlpatterns = [
    path("", ScoreView.as_view()),
    path("", include(router.urls)),
    path("inventory/", InventoryView.as_view()),
]
