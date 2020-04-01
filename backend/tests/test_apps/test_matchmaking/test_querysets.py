# -*- coding: utf-8 -*-

import pytest

from server.apps.matchmaking.models import Match
from tests.factories import CompanyFactory, ProfileFactory, StartupFactory


@pytest.mark.django_db
def test_get_matches_for_investor():
    # prepare srodowisko do testow
    # GIVEN profile assigned to company
    profile = ProfileFactory.create()
    company = CompanyFactory.create(profiles=[profile])
    # GIVEN matches startup <-> investor.
    startup = StartupFactory.create()
    # TODO: create utility function to generate random matches...
    # WHEN get_matches is triggered
    matches = Match.objects.get_matches(profile=profile)
    # THEN return matches with the highest result
    ...
