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
        # do smth with mypy types
        matches = Match.objects.get_matches(profile=request.user.profile)
        # "Name"
        # "Title" | "Company" -> if exists or None
        # Result
        serializer = MatchmakingListOutputSerializer(matches, many=True)

        return Response(serializer.data)
