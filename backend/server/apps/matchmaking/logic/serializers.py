# -*- coding: utf-8 -*-

from rest_framework import serializers

from server.apps.matchmaking.models import Match
from server.apps.profile.models import InvestorProfile, Startup


class StartupNestedOutputSerializer(serializers.ModelSerializer):
    class Meta:
        model = Startup
        fields = ['id', 'name', 'logotype']
        read_only_fields = fields


class AngelInvestorNestedOutputSerializer(serializers.ModelSerializer):
    name = serializers.CharField(
        source='angelinvestor.profile.name',
        read_only=True,
    )
    avatar = serializers.CharField(
        source='angelinvestor.avatar',
        read_only=True,
    )

    class Meta:
        model = InvestorProfile
        fields = ['id', 'avatar', 'name']
        read_only_fields = fields


class CompanyNestedOutputSerializer(serializers.ModelSerializer):
    name = serializers.CharField(source='company.name', read_only=True)
    logotype = serializers.CharField(source='company.logotype', read_only=True)

    class Meta:
        model = InvestorProfile
        fields = ['id', 'name', 'logotype']
        read_only_fields = fields


class InvestorProfileObjectRelatedField(serializers.RelatedField):

    def to_representation(self, value: InvestorProfile):
        # move to another function this logic
        if hasattr(value, 'angelinvestor'):
            return AngelInvestorNestedOutputSerializer(instance=value).data
        if hasattr(value, 'company'):
            return CompanyNestedOutputSerializer(instance=value).data


class MatchmakingListOutputSerializer(serializers.ModelSerializer):
    """Serializes matching data. It's supposed to be used in MatchmakingList."""

    startup = StartupNestedOutputSerializer(read_only=True)
    investor = InvestorProfileObjectRelatedField(read_only=True)

    class Meta:
        model = Match
        fields = ['result', 'startup', 'investor']
        read_only_fields = fields
