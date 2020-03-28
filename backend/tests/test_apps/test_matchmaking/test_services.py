# -*- coding: utf-8 -*-

# flake8: noqa

import pytest
from psycopg2.extras import NumericRange

from server.apps.matchmaking.logic.services import (
  MatchingData,
  Matchmaking,
  create_matches_for_startup,
)
from server.apps.matchmaking.models import Match
from server.apps.profile.constants import (
  BusinessType,
  CompanyStage,
  Industry,
  InvestmentStage,
  ProductType,
  Sector,
)
from server.apps.profile.models import InvestorProfile
from tests.factories import InvestorProfileFactory, CompanyFactory


class TestMatchmaking:
    """Test matchmaking process."""

    MATCHING_DATA1 = MatchingData(
        CompanyStage.CONCEPT_STAGE,
        [Sector.AI_AND_ROBOTICS],
        [Industry.FINANCIAL_SERVICES],
        [ProductType.SOFTWARE],
        [InvestmentStage.BUSINESS_ANGELS],
        False,
        BusinessType.B2B,
        NumericRange(2, 1),
    )
    MATCHING_DATA2 = MatchingData(
        CompanyStage.SEED_STAGE,
        [Sector.IOT_AND_SENSORS],
        [Industry.HEALTH_CARE],
        [ProductType.HARDWARE],
        [InvestmentStage.INCUBATOR],
        True,
        BusinessType.B2C,
        NumericRange(5, 6),
    )

    @pytest.mark.parametrize('investor_data, startup_data, expected', [
        (MATCHING_DATA1, MATCHING_DATA1, 100),
        (MATCHING_DATA1, MATCHING_DATA2, 0),
    ])
    def test_run_matchmaking_algorithm(
        self, investor_data, startup_data, expected, startup, company,
    ):
        result = Matchmaking(startup, company)._run_matchmaking_algorithm(
            investor_data, startup_data,
        )
        assert result == expected

    def test_calculate_result(self, startup):
        # GIVEN a startup and an investor
        investor = InvestorProfileFactory.create(company=CompanyFactory.build())
        # WHEN calculate_result is triggered
        # THEN run algorithm which returns matchmaking result as value <0;100>
        result = Matchmaking(startup, investor).calculate_result()

        assert 0 <= result <= 100


def test_create_matches_for_startup(startup, company, angel_investor):
    # GIVEN a startup and two investors
    investors = InvestorProfile.objects.all()
    # WHEN create_matches_for_startup is triggered
    # THEN match given startup with given investors
    matches = create_matches_for_startup(startup=startup, investors=investors)

    assert list(Match.objects.all()) == matches
