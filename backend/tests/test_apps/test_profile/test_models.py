# -*- coding: utf-8 -*-

from django.contrib.auth import get_user_model

from server.apps.profile.models import Profile

User = get_user_model()


def test_profile_string_representation(user):
    """Ensures that Profile and User models representations are the same."""
    profile = Profile(user=user)

    assert str(profile) == str(user)
