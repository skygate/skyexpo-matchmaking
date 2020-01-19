# -*- coding: utf-8 -*-

from server.apps.matchmaking.logic.services import Matchmaking
from server.apps.matchmaking.models import Match
from server.apps.profile.models import InvestorProfile


def test_match_string_representation(startup, angel_investor):
    # GIVEN Match model
    investor = InvestorProfile.objects.first()
    result = Matchmaking(startup, investor).calculate_result()
    match = Match(startup=startup, investor=investor, result=result)
    match.save()

    expected = '{startup}, {investor}, {result}'.format(
        startup=str(match.startup),
        investor=str(match.investor),
        result=match.result,
    )
    assert str(match) == expected
