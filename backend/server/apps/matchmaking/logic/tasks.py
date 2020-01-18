# -*- coding: utf-8 -*-
from typing import List

from celery import shared_task

from server.apps.matchmaking.logic.services import create_matches_for_startup
from server.apps.matchmaking.models import Match
from server.apps.profile.models import InvestorProfile, Startup


@shared_task
def match_startup_with_investors(*, startup_id: int) -> List[Match]:
    startup = Startup.objects.get(id=startup_id)
    investors = InvestorProfile.objects.all()

    return create_matches_for_startup(startup=startup, investors=investors)
