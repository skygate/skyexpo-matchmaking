# -*- coding: utf-8 -*-

import pytest
from rest_framework import serializers

from server.apps.matchmaking.logic.serializers import (
  InvestorProfileObjectRelatedField,
  MatchmakingListOutputSerializer,
)
from server.apps.matchmaking.models import Match
from tests.factories import AngelInvestorFactory, CompanyFactory, MatchFactory


class SerializerClass(serializers.ModelSerializer):
    """Serializer used for test InvestorProfileObjectRelatedField"""

    investor = InvestorProfileObjectRelatedField(read_only=True)

    class Meta:
        model = Match
        fields = ['investor']


@pytest.mark.django_db
def test_investor_profile_object_related_field():
    # GIVEN investors - angel investor and company

    angel_investor = AngelInvestorFactory.create()
    company = CompanyFactory.create()
    MatchFactory.create(investor=angel_investor)
    MatchFactory.create(investor=company)

    # WHEN angel investor or company passed to Serializer where
    # InvestorProfileObjectRelatedField is used.
    serializer = SerializerClass(Match.objects.all(), many=True)
    # THEN return CompanyNestedOutputSerializer
    # or AngelInvestorNestedOutputSerializer

    for investor_data in serializer.data:
        assert set(investor_data['investor'].keys()) == {
            'id',
            'name',
            'logotype',
        }


def test_matchmaking_list_output_serializer():
    match = MatchFactory.build(investor=CompanyFactory.build())
    serializer = MatchmakingListOutputSerializer(match)

    assert set(serializer.data.keys()) == {'result', 'startup', 'investor'}
