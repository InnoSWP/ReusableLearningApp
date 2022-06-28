from rest_framework import serializers
from .models import UserScore, ShopItem


class UserScoreSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserScore
        fields = ["score"]


class ShopItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShopItem
        fields = ["id", "name", "description", "price", "image_url"]
