# -*- coding: utf-8 -*-

import pytest

from server.apps.profile.logic.selectors import is_assigned
from server.apps.profile.logic.services import assign_profile_to_startup
from tests.factories import ProfileFactory


@pytest.mark.django_db
def test_profile_is_assigned(startup):
    profile = ProfileFactory.create()
    assign_profile_to_startup(profile=profile, startup=startup)

    assert is_assigned(profile=profile)


@pytest.mark.django_db
def test_profile_is_unassigned():
    profile = ProfileFactory.create()

    assert not is_assigned(profile=profile)
