# -*- coding: utf-8 -*-

from typing import Type, List

from django.db.models import QuerySet

from server.apps.matchmaking.models import Match
from server.apps.profile.models import Startup, InvestorProfile


def get_matchmaking_result(
    *, startup: Startup, investor: InvestorProfile
) -> int:
    matching_args = [
        'stage', 'sectors', 'industries', 'product_types', 'investment_stage',
        'is_product_on_market', 'investment_size',
    ]
    matching_obj = getattr(investor, 'company', 'angelinvestor')

    return 1


def calculate_matches_for_startup(
    *, startup: Startup, investors: 'QuerySet[InvestorProfile]'
) -> List[Match]:
    matches = (
        Match(startup=startup, investor=investor,
              result=get_matchmaking_result(startup=startup, investor=investor))
        for investor in investors
    )
    return Match.objects.bulk_create(matches)
