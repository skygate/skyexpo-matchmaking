# -*- coding: utf-8 -*-

from typing import List, Union

from django.db.models import QuerySet
from psycopg2.extras import NumericRange
from typing_extensions import Final

from server.apps.matchmaking.models import Match
from server.apps.profile.models import (
  AngelInvestor,
  BaseMatchmakingInfo,
  Company,
  InvestorProfile,
  Startup,
)

MatchingValueType = Union[str, List[str], bool, NumericRange]


class Matchmaking:
    """Represents logic which stands behind matchmaking process."""

    def __init__(self, startup: Startup, investor: InvestorProfile):
        self.startup = startup
        self.investor = investor

    MATCHING_ARGS: Final = [
        'stage',
        'sectors',
        'industries',
        'product_types',
        'investment_stage',
        'is_product_on_market',
        'business_type',
        'investment_size',
    ]

    def calculate_result(self) -> int:
        """Calculate investor's match to startup."""
        investor_child = self._get_investor_child_obj()
        investor_child_values = self._get_matching_values(investor_child)
        startup_values = self._get_matching_values(self.startup)

        return self._run_matchmaking_algorithm(
            investor_child_values, startup_values,
        )

    def _get_investor_child_obj(self) -> Union[Company, AngelInvestor]:
        try:
            return self.investor.company
        except AttributeError:
            return self.investor.angelinvestor

    def _get_matching_values(
        self, obj: BaseMatchmakingInfo,
    ) -> List[MatchingValueType]:
        return [
            getattr(obj, arg) for arg in self.MATCHING_ARGS
        ]

    def _run_matchmaking_algorithm(
        self,
        investor_values: List[MatchingValueType],
        startup_values: List[MatchingValueType],
    ) -> int:
        same = 0
        for investor_val, startup_val in zip(investor_values, startup_values):
            if investor_val == startup_val:
                same += 1

        return int(same / len(self.MATCHING_ARGS) * 100)


def create_matches_for_startup(
    *, startup: Startup, investors: 'QuerySet[InvestorProfile]',
) -> List[Match]:
    matches = (
        Match(
            startup=startup,
            investor=investor,
            result=Matchmaking(startup, investor).calculate_result(),
        ) for investor in investors
    )
    return Match.objects.bulk_create(matches)
