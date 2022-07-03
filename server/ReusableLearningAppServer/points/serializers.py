from rest_framework import serializers
from django.contrib.auth import get_user_model
from progress.models import LessonProgress
from .models import UserScore, ShopItem

User = get_user_model()


class UserScoreSerializer(serializers.ModelSerializer):
    lessons_passed = serializers.IntegerField(read_only=True)

    class Meta:
        model = UserScore
        fields = ["score"]

    def to_representation(self, instance):
        user = self.context["request"].user
        return {
            "score": instance.score,
            "lessons_passed": (
                LessonProgress
                .objects
                .filter(user=user, status=LessonProgress.StatusType.COMPLETED)
                .count()
            )
        }


class ShopItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShopItem
        fields = ["id", "name", "description", "price", "image_url"]
