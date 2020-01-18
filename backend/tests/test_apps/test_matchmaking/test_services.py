# -*- coding: utf-8 -*-

from server.apps.matchmaking.logic.services import calculate_matches_for_startup
from server.apps.matchmaking.models import Match
from server.apps.profile.models import InvestorProfile


def test_calculate_matches_for_startup(startup, company, angel_investor):
    # GIVEN a startup and investors
    investors = InvestorProfile.objects.all()
    # WHEN calculate_matches_for_startup is triggered
    # THEN match given startup with given investors
    matches = calculate_matches_for_startup(startup=startup, investors=investors)

    assert list(Match.objects.all()) == matches
