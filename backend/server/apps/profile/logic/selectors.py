# -*- coding: utf-8 -*-

from typing import Optional

from server.apps.profile.models import (
  AngelInvestor,
  InvestorProfile,
  Profile,
  Startup,
)


def is_assigned(*, profile: Profile):
    # może lepiej try except?
    investor = AngelInvestor.objects.filter(profile=profile).exists()
    if (
        investor or
        profile.companies.exists() or  # type: ignore
        profile.startups.exists()  # type: ignore
    ):
        return True
    return False


def get_investor(*, profile: Profile) -> InvestorProfile:
    try:
        return AngelInvestor.objects.get(profile=profile)
    except AngelInvestor.DoesNotExist:
        # tutaj zamienić na try except też??
        return profile.companies.first()


def get_startup(*, profile) -> Optional[Startup]:
    # tutaj zamienić na try except?
    # do smth with mypy types
    return profile.startups.first()
