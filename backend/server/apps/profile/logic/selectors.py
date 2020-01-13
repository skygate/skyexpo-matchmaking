# -*- coding: utf-8 -*-

from server.apps.profile.models import AngelInvestor, Profile


def is_assigned(*, profile: Profile):
    investor = AngelInvestor.objects.filter(profile=profile).exists()
    if investor or profile.companies.exists() or profile.startups.exists():
        return True
    return False
