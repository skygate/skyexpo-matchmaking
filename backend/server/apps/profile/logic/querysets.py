# -*- coding: utf-8 -*-

from typing import TYPE_CHECKING

from django.db import models
from django.db.models.query import QuerySet

if TYPE_CHECKING:  # pragma: no cover
    from server.apps.profile.models import Profile  # noqa: WPS433
    BaseQuerySetType = models.QuerySet[Profile]
else:
    BaseQuerySetType = models.QuerySet


class ProfileQuerySet(BaseQuerySetType):
    """Custom QuerySet for Profile model."""

    def active_profiles(self) -> 'QuerySet[Profile]':
        # TODO: When we will have investors change it to company|investor!=NULL
        return self.filter(company__isnull=False)
