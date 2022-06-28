from rest_framework.views import APIView
from rest_framework.decorators import action
from rest_framework.viewsets import ReadOnlyModelViewSet
from rest_framework import permissions
from rest_framework.response import Response
from django.shortcuts import get_object_or_404

from .models import UserScore, ShopItem
from .serializers import UserScoreSerializer, ShopItemSerializer


class ShopView(ReadOnlyModelViewSet):
    permissions = [permissions.IsAuthenticated]
    pagination_class = None

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


class ScoreView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        return Response(
            UserScoreSerializer(
                UserScore.get_score(user=request.user)
            ).data
        )


class InventoryView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        return Response(
            ShopItemSerializer(
                ShopItem.get_inventory(request.user),
                many=True
            ).data
        )
