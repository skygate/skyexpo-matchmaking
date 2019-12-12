# -*- coding: utf-8 -*-

import pytest

from server.apps.profile.models import (
  CompanyToProfile,
  Profile,
  StartupToProfile,
)
from tests.factories import ProfileFactory


@pytest.mark.django_db
def test_query_for_unassigned_profiles(company, startup):
    """
    Filters for unassigned profiles. Unassigned means that profile is not
    linked with any Company / Startup or AngelInvestor.
    """
    unassigned_profiles = [ProfileFactory.create(), ProfileFactory.create()]

    profile_assigned1 = ProfileFactory.create()
    CompanyToProfile.objects.create(profile=profile_assigned1, company=company)

    assert list(Profile.objects.unassigned_profiles()) == unassigned_profiles

    profile_assigned2 = ProfileFactory.create()
    StartupToProfile.objects.create(profile=profile_assigned2, startup=startup)

    assert list(Profile.objects.unassigned_profiles()) == unassigned_profiles
