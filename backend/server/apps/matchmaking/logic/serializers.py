# -*- coding: utf-8 -*-

from rest_framework import serializers

from server.apps.matchmaking.models import Match


class MatchmakingListOutputSerializer(serializers.ModelSerializer):
    """Serializes matching data. It's supposed to be used in MatchmakingList."""

    class Meta:
        model = Match
        fields = ['result', 'startup', 'investor']
        read_only_fields = fields
