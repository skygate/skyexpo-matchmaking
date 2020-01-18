# -*- coding: utf-8 -*-

from server.apps.matchmaking.logic.services import create_matches_for_startup, \
    Matchmaking
from server.apps.matchmaking.models import Match
from server.apps.profile.models import InvestorProfile


def test_create_matches_for_startup(startup, company, angel_investor):
    # GIVEN a startup and investors
    investors = InvestorProfile.objects.all()
    # WHEN create_matches_for_startup is triggered
    # THEN match given startup with given investors
    matches = create_matches_for_startup(startup=startup, investors=investors)

    assert list(Match.objects.all()) == matches


def test_calculate_matchmaking_result(startup, company):
    # GIVEN a startup and an investor
    investor = InvestorProfile.objects.first()
    # WHEN calculate_result is triggered
    # THEN run algorithm which returns matchmaking result as value <0;100>

    result = Matchmaking(startup, investor).calculate_result()

    assert 0 <= result <= 100
