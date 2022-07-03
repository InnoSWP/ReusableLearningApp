from rest_framework.views import APIView
from rest_framework.decorators import action
from rest_framework.viewsets import ReadOnlyModelViewSet
from rest_framework.generics import RetrieveAPIView, ListAPIView
from rest_framework import permissions
from rest_framework.response import Response
from django.shortcuts import get_object_or_404

from .models import UserScore, ShopItem
from .serializers import UserScoreSerializer, ShopItemSerializer


class ShopView(ReadOnlyModelViewSet):
    permissions = [permissions.IsAuthenticated]

    queryset = ShopItem.objects.all()
    serializer_class = ShopItemSerializer

    @action(detail=True, methods=["post"])
    def buy(self, request, pk):
        item = get_object_or_404(ShopItem, pk=pk)
        if ShopItem.objects.filter(pk=pk, owners=request.user):
            return Response(data={
                "reason": "already owns"
            }, status=400)

        if item.buy(request.user):
            return Response(status=201)
        return Response(data={
            "reason": "not enough points"
        }, status=400)


class ScoreView(RetrieveAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = UserScoreSerializer

    def get_object(self):
        return UserScore.get_score(self.request.user)


class InventoryView(ListAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = ShopItemSerializer

    def get_queryset(self):
        return ShopItem.get_inventory(self.request.user)
