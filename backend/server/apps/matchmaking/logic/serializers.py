# -*- coding: utf-8 -*-

from drf_yasg import openapi
from rest_framework import serializers

from server.apps.matchmaking.models import Match
from server.apps.profile.models import InvestorProfile, Startup


class StartupNestedOutputSerializer(serializers.ModelSerializer):
    """Serializes Startup instances in a MatchmakingList view."""

    class Meta:
        model = Startup
        fields = ['id', 'name', 'logotype']
        read_only_fields = fields


class AngelInvestorNestedOutputSerializer(serializers.ModelSerializer):
    """Serializes AngelInvestor instances in a MatchmakingList view."""

    name = serializers.CharField(
        source='angelinvestor.profile.name',
        read_only=True,
    )
    logotype = serializers.CharField(
        source='angelinvestor.logotype',
        read_only=True,
    )

    class Meta:
        model = InvestorProfile
        fields = ['id', 'name', 'logotype']
        read_only_fields = fields


class CompanyNestedOutputSerializer(serializers.ModelSerializer):
    """Serializes Company instances in a MatchmakingList view."""

    name = serializers.CharField(source='company.name', read_only=True)
    logotype = serializers.CharField(source='company.logotype', read_only=True)

    class Meta:
        model = InvestorProfile
        fields = ['id', 'name', 'logotype']
        read_only_fields = fields


class InvestorProfileObjectRelatedField(serializers.RelatedField):
    """
    Decides whom serializer use to serialize InvestorProfile.
    It is needed because we implement Multi-Table Inheritance there.
    """

    def to_representation(self, instance: InvestorProfile):
        if instance.is_angel_investor:
            return AngelInvestorNestedOutputSerializer(instance=instance).data
        if instance.is_company:
            return CompanyNestedOutputSerializer(instance=instance).data

    class Meta:
        # TODO: Make this dynamic based on used serializers in to_representation
        swagger_schema_fields = {
            'type': 'object',
            'properties': {
                'id': {'type': openapi.TYPE_INTEGER},
                'name': {'type': openapi.TYPE_STRING},
                'logotype': {
                    'type': openapi.TYPE_STRING,
                    'format': openapi.FORMAT_URI,
                },
            },
        }


class MatchmakingListOutputSerializer(serializers.ModelSerializer):
    """Serializes matching data. It's supposed to be used in MatchmakingList."""

    startup = StartupNestedOutputSerializer(read_only=True)
    investor = InvestorProfileObjectRelatedField(read_only=True)

    class Meta:
        model = Match
        fields = ['result', 'startup', 'investor']
        read_only_fields = fields
