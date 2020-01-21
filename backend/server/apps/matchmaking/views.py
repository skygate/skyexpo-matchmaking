# -*- coding: utf-8 -*-

from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from rest_framework import permissions, status, views
from rest_framework.request import Request
from rest_framework.response import Response

from server.apps.matchmaking.logic.serializers import (
  MatchmakingListOutputSerializer,
)
from server.apps.matchmaking.models import Match
from server.utils.exception_handler import ExceptionHandlerMixin


class MatchmakingListView(ExceptionHandlerMixin, views.APIView):
    """..."""

    permission_classes = [permissions.IsAuthenticated]

    @swagger_auto_schema(
        request_body=...,
        responses={
            status.HTTP_200_OK: openapi.Response(description=''),
        },
    )
    def get(self, request: Request) -> Response:
        # to nie jest takie proste....
        # trzeba to przeniesć do querysetu jednak
        # pobieram usera i sprawdzam czy on nalezy do investora czy startupu
        # i wtedy wyswietlam matchingi na podstawie investora / startupu
        matches = Match.objects.filter(user=request.user).select_related('')
        serializer = MatchmakingListOutputSerializer(matches, many=True)

        return Response(serializer.data)
