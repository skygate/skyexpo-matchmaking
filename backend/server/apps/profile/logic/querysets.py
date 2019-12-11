# -*- coding: utf-8 -*-

from typing import TYPE_CHECKING

from django.db import models
from django.db.models.query import QuerySet

if TYPE_CHECKING:  # pragma: no cover
    from server.apps.profile.models import Profile  # noqa: WPS433
    BaseQuerySetType = QuerySet[Profile]
else:
    BaseQuerySetType = QuerySet


class ProfileQuerySet(BaseQuerySetType):
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
