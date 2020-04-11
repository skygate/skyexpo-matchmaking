# -*- coding: utf-8 -*-

import contextlib

from server.apps.profile.models import AngelInvestor, InvestorProfile, Profile


def is_assigned(*, profile: Profile):
    investor = AngelInvestor.objects.filter(profile=profile).exists()
    if investor or profile.companies.exists() or profile.startups.exists():
        return True
    return False


def get_investor(*, profile: Profile) -> InvestorProfile:
    with contextlib.suppress(AngelInvestor.DoesNotExist):
        return AngelInvestor.objects.get(profile=profile)
    try:
        return profile.company
    except AttributeError:
        raise ValueError(f'Profile {profile.name} is not investor.')
