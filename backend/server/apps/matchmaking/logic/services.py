# -*- coding: utf-8 -*-

from dataclasses import astuple, dataclass
from typing import Final, List

from django.db.models import QuerySet
from psycopg2.extras import NumericRange

from server.apps.matchmaking.models import Match
from server.apps.profile.models import (
  BaseMatchmakingInfo,
  InvestorProfile,
  Startup,
)


@dataclass(frozen=True)
class MatchingData:
    """Container that represents data used to calculate matchmaking value."""

    stage: str
    sectors: List[str]
    industries: List[str]
    product_types: List[str]
    investment_stage: List[str]
    is_product_on_market: bool
    business_type: str
    investment_size: NumericRange

    def __iter__(self):
        return iter(astuple(self))


class Matchmaking:
    """Represents logic which stands behind matchmaking process."""

    def __init__(self, startup: Startup, investor: InvestorProfile):
        self.startup = startup
        self.investor = investor

        self.MATCHING_ARGS: Final = [
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
        investor = self.investor.get_child_instance()
        investor_data = self._get_matching_data(investor)
        startup_data = self._get_matching_data(self.startup)

        return self._run_matchmaking_algorithm(
            investor_data, startup_data,
        )

    def _get_matching_data(
        self, model_instance: BaseMatchmakingInfo,
    ) -> MatchingData:
        return MatchingData(
            **{arg: getattr(model_instance, arg) for arg in self.MATCHING_ARGS},
        )

    def _run_matchmaking_algorithm(
        self,
        investor_data: MatchingData,
        startup_data: MatchingData,
    ) -> int:
        same = 0
        for investor_val, startup_val in zip(investor_data, startup_data):
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
