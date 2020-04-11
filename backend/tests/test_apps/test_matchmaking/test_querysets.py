# -*- coding: utf-8 -*-

import pytest

from server.apps.matchmaking.models import Match
from tests.factories import (
  CompanyFactory,
  MatchFactory,
  ProfileFactory,
  StartupFactory,
)


@pytest.mark.django_db
def test_get_matches_for_investor(django_assert_max_num_queries):
    # GIVEN profile assigned to company
    profile = ProfileFactory.create()
    company = CompanyFactory.create(profiles=[profile])
    # GIVEN 100 matchings with 100 random startups
    MatchFactory.create_batch(size=100, investor=company)
    # WHEN get_matches is triggered
    with django_assert_max_num_queries(3):
        matches = Match.objects.get_matches(profile=profile)
    # THEN return 100 matches objects ordered by the highest value
    assert list(matches) == list(
        Match.objects.filter(investor=company).order_by('-result'),
    )
    assert matches.count() == Match.objects.filter(investor=company).count()

    # GIVEN 100 matchings with 100 random startups + 3 duplicated startups
    startup = StartupFactory.create()
    MatchFactory.create(investor=company, startup=startup, result=90)
    MatchFactory.create(investor=company, startup=startup, result=88)
    MatchFactory.create(investor=company, startup=startup, result=13)

    # WHEN get_matches is triggered
    with django_assert_max_num_queries(3):
        matches = Match.objects.get_matches(profile=profile)
    # THEN get the highest value from the same startup
    assert matches.count() == 101
    matches_results = matches.values_list('result', flat=True)
    assert sorted(matches_results, reverse=True) == list(matches_results)
    assert Match.objects.filter(
        startup=startup,
        investor=company,
        result=90,
    ).exists()


@pytest.mark.django_db
def test_get_matches_for_startup(django_assert_max_num_queries):
    # GIVEN profile assigned to startup
    profile = ProfileFactory.create()
    startup = StartupFactory.create(profiles=[profile])
    # GIVEN 100 matchings with 100 random investors
    for _ in range(100):  # noqa: WPS122
        MatchFactory.create(startup=startup, investor=CompanyFactory.create())
    # WHEN get_matches is triggered
    with django_assert_max_num_queries(3):
        matches = Match.objects.get_matches(profile=profile)
    # THEN return 100 matches objects ordered by the highest value
    assert list(matches) == list(
        Match.objects.filter(startup=startup).order_by('-result'),
    )
    assert matches.count() == Match.objects.filter(startup=startup).count()

    # GIVEN 100 matchings with 100 random investors + 3 duplicated investors
    company = CompanyFactory.create()
    MatchFactory.create(investor=company, startup=startup, result=100)
    MatchFactory.create(investor=company, startup=startup, result=10)
    MatchFactory.create(investor=company, startup=startup, result=30)

    # WHEN get_matches is triggered
    with django_assert_max_num_queries(3):
        matches = Match.objects.get_matches(profile=profile)
    # THEN get the highest value from the same investor
    assert matches.count() == 101
    matches_results = matches.values_list('result', flat=True)
    assert sorted(matches_results, reverse=True) == list(matches_results)
    assert Match.objects.filter(
        startup=startup,
        investor=company,
        result=100,
    ).exists()
