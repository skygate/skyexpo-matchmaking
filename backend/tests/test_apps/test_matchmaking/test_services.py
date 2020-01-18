# -*- coding: utf-8 -*-
import pytest
from psycopg2.extras import NumericRange

from server.apps.matchmaking.logic.services import (
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
from server.apps.profile.models import AngelInvestor, Company, InvestorProfile


class TestMatchmaking:
    MATCHING_VALUES_1 = [
        CompanyStage.CONCEPT_STAGE,
        [Sector.AI_AND_ROBOTICS],
        [Industry.FINANCIAL_SERVICES],
        [ProductType.SOFTWARE],
        [InvestmentStage.BUSINESS_ANGELS],
        False,
        BusinessType.B2B,
        NumericRange(2, 1),
    ]
    MATCHING_VALUES_2 = [
        CompanyStage.SEED_STAGE,
        [Sector.IOT_AND_SENSORS],
        [Industry.HEALTH_CARE],
        [ProductType.HARDWARE],
        [InvestmentStage.INCUBATOR],
        True,
        BusinessType.B2C,
        NumericRange(5, 6),
    ]

    def test_get_investor_child_obj(self, startup, company, angel_investor):
        # GIVEN company and angelinvestor as investors
        match_company = Matchmaking(startup, company)
        match_investor = Matchmaking(startup, angel_investor)
        # WHEN func is triggered
        match_company_child = match_company._get_investor_child_obj()
        match_investor_child = match_investor._get_investor_child_obj()
        # THEN return appropriate child object
        assert isinstance(match_company_child, Company)
        assert isinstance(match_investor_child, AngelInvestor)

    @pytest.mark.parametrize('investor_values, startup_values, expected', [
                                 (MATCHING_VALUES_1, MATCHING_VALUES_1, 100),
                                 (MATCHING_VALUES_1, MATCHING_VALUES_2, 0)
    ])
    def test_run_matchmaking_algorithm(
        self, investor_values, startup_values, expected, startup, company
    ):
        result = Matchmaking(startup, company)._run_matchmaking_algorithm(
            investor_values, startup_values,
        )
        assert result == expected

    def test_calculate_result(self, startup, company):
        # GIVEN a startup and an investor
        investor = InvestorProfile.objects.first()
        # WHEN calculate_result is triggered
        # THEN run algorithm which returns matchmaking result as value <0;100>
        result = Matchmaking(startup, investor).calculate_result()

        assert 0 <= result <= 100


def test_create_matches_for_startup(startup, company, angel_investor):
    # GIVEN a startup and investors
    investors = InvestorProfile.objects.all()
    # WHEN create_matches_for_startup is triggered
    # THEN match given startup with given investors
    matches = create_matches_for_startup(startup=startup, investors=investors)

    assert list(Match.objects.all()) == matches
