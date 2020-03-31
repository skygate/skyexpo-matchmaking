# -*- coding: utf-8 -*-

from typing import TYPE_CHECKING

from django.db.models import QuerySet

from server.apps.profile.logic.selectors import get_investor

if TYPE_CHECKING:  # pragma: no cover
    from server.apps.matchmaking.models import Match  # noqa: WPS433
    MatchQuerySetBaseType = QuerySet[Match]
else:
    MatchQuerySetBaseType = QuerySet


class MatchQuerySet(MatchQuerySetBaseType):
    """Custom QuerySet for Match model."""

    def get_matches(self, *, profile) -> 'QuerySet[Match]':
        try:
            return self.filter(startup=profile.startup)
        except AttributeError:
            # else must be an investor
            return self.filter(investor=get_investor(profile=profile))
