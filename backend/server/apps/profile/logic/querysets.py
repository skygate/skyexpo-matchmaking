# -*- coding: utf-8 -*-

from typing import TYPE_CHECKING

from django.db import models
from django.db.models import Q

if TYPE_CHECKING:  # pragma: no cover
    from server.apps.profile.models import Profile  # noqa: WPS433
    BaseQuerySetType = models.QuerySet[Profile]
else:
    BaseQuerySetType = models.QuerySet


class ProfileQuerySet(BaseQuerySetType):
    """Custom QuerySet for Profile model."""

    def unassigned_profiles(self) -> 'QuerySet[Profile]':
        """
        Inactive profile is a profile that doesn't belong to
        neither Company, Startup or AngelInvestor.
        """
        return self.filter(Q(company__isnull=True) & Q(angel_investor__isnull=True) & Q(startup__isnull=True))
