# -*- coding: utf-8 -*-

import pytest

from server.apps.profile.models import Profile
from tests.factories import ProfileFactory


@pytest.mark.django_db
def test_filter_active_profiles(django_assert_num_queries):
    """Ensures that 'objects.active_profiles' returns only active profiles."""
    ProfileFactory.create(company=None)
    ProfileFactory.create()

    with django_assert_num_queries(1):
        queryset = Profile.objects.active_profiles()
        assert queryset.count() == 1
