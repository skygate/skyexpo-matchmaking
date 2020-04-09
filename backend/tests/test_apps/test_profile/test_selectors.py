# -*- coding: utf-8 -*-

import pytest

from server.apps.profile.logic.selectors import get_investor, is_assigned
from server.apps.profile.logic.services import assign_profile_to_startup
from tests.factories import AngelInvestorFactory, CompanyFactory, ProfileFactory


@pytest.mark.django_db
def test_profile_is_assigned(startup):
    profile = ProfileFactory.create()
    assign_profile_to_startup(profile=profile, startup=startup)

    assert is_assigned(profile=profile)


@pytest.mark.django_db
def test_profile_is_unassigned():
    profile = ProfileFactory.create()

    assert not is_assigned(profile=profile)


@pytest.mark.django_db
def test_get_investor_angel_investor():
    investor = AngelInvestorFactory.create()
    investor_profile = investor.profile

    assert get_investor(profile=investor_profile) == investor


@pytest.mark.django_db
def test_get_investor_company_investor():
    profile = ProfileFactory.create()
    company = CompanyFactory.create(profiles=[profile])

    assert get_investor(profile=profile) == company


@pytest.mark.django_db
def test_get_investor_not_investor():
    profile = ProfileFactory.create()

    with pytest.raises(
        ValueError, match=f'Profile {profile.name} is not investor.',
    ):
        get_investor(profile=profile)
