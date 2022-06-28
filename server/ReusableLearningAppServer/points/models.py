from typing import Callable, List
from django.core.exceptions import ValidationError
from django.db import models
from django.contrib.auth import get_user_model


User = get_user_model()


class UserScore(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="score")
    score = models.IntegerField(default=0)

    def __str__(self):
        return f"UserScore(user={self.user.username}, score={self.score})"

    @staticmethod
    def get_score(user: User) -> "UserScore":
        return UserScore.objects.get_or_create(user=user)[0]

    @classmethod
    def update_score(cls, user: User, func: Callable[[int], list[float]]) -> "UserScore":
        score = cls.get_score(user)
        score.score = func(score.score)
        score.save()


def validate_point_price(points: int):
    if points < 1:
        raise ValidationError(
            f"Points can't be less than 1; current - {points}"
        )


class ShopItem(models.Model):
    name = models.CharField(max_length=64, unique=True)
    description = models.TextField()
    price = models.IntegerField(default=100, validators=[validate_point_price])
    image_url = models.TextField()

    owners = models.ManyToManyField(User, blank=True)

    def __str__(self):
        return f"ShopItem(name={self.name}, price={self.price})"

    def buy(self, user: User) -> bool:
        score = UserScore.get_score(user)
        new_score = score.score - self.price
        if new_score < 0:
            return False
        score.update_score(user, lambda x: x - self.price)
        self.owners.add(user)
        return True

    @staticmethod
    def get_inventory(user: User) -> List["ShopItem"]:
        return ShopItem.objects.filter(owners=user).all()
