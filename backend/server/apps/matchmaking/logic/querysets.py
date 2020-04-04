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
            top_results = (
                self.filter(startup=profile.startup)
                    .order_by('investor', '-result')
                    .distinct('investor')
            )
        except AttributeError:
            # else must be an investor
            top_results = (
                self.filter(investor=get_investor(profile=profile))
                    .order_by('startup', '-result')
                    .distinct('startup')
            )
        return self.filter(pk__in=top_results).order_by('-result')
