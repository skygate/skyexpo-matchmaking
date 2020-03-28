# -*- coding: utf-8 -*-

from server.apps.matchmaking.logic.services import Matchmaking
from server.apps.matchmaking.models import Match
from tests.factories import AngelInvestorFactory, InvestorProfileFactory


def test_match_string_representation(startup):
    # GIVEN Match model
    investor = InvestorProfileFactory.create(
        angelinvestor=AngelInvestorFactory.build(),
    )
    result = Matchmaking(startup, investor).calculate_result()
    match = Match(startup=startup, investor=investor, result=result)
    match.save()

    expected = '{startup}, {investor}, {result}'.format(
        startup=str(match.startup),
        investor=str(match.investor),
        result=match.result,
    )
    assert str(match) == expected
