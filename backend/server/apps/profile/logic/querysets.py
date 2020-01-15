# -*- coding: utf-8 -*-

from typing import TYPE_CHECKING

from django.db import models
from django.db.models.query import QuerySet

if TYPE_CHECKING:  # pragma: no cover
    from server.apps.profile.models import Profile  # noqa: WPS433
    from server.apps.profile.models import User  # noqa: WPS433
    ProfileQuerySetBaseType = QuerySet[Profile]
    UserQuerySetBaseType = QuerySet[User]
else:
    ProfileQuerySetBaseType = QuerySet
    UserQuerySetBaseType = QuerySet


class ProfileQuerySet(ProfileQuerySetBaseType):
    """Custom QuerySet for Profile model."""

    def unassigned_profiles(self) -> 'QuerySet[Profile]':
        """
        Unassigned profile is a profile that doesn't belong to
        neither Company, Startup or AngelInvestor.
        """
        return self.filter(
            models.Q(angel_investor__isnull=True),
            models.Q(companies__isnull=True),
            models.Q(startups__isnull=True),
        )


class UserQuerySet(UserQuerySetBaseType):
    """Custom QuerySet for User model."""

    def active_users(self) -> 'QuerySet[User]':
        """
        The active user is the user that is registered and his
        profile is assigned.
        """
        return self.filter(is_active=True)
