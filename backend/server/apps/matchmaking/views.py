# -*- coding: utf-8 -*-

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
    """Displays the matching list for the user who uses this endpoint."""

    permission_classes = [permissions.IsAuthenticated]

    @swagger_auto_schema(
        responses={
            status.HTTP_200_OK: MatchmakingListOutputSerializer,
        },
    )
    def get(self, request: Request) -> Response:
        matches = Match.objects.get_matches(  # type: ignore
            profile=request.user.profile,
        ).select_related(
            'startup',
            'investor',
            'investor__angelinvestor',
            'investor__angelinvestor__profile',
            'investor__company',
        )
        serializer = MatchmakingListOutputSerializer(matches, many=True)

        return Response(serializer.data, status=status.HTTP_200_OK)
