# -*- coding: utf-8 -*-

from celery import shared_task

from server.apps.matchmaking.logic.services import create_matches_for_startup
from server.apps.profile.models import InvestorProfile, Startup


@shared_task
def match_startup_with_investors(*, startup_id: int) -> None:
    startup = Startup.objects.get(id=startup_id)
    investors = InvestorProfile.objects.all()

    create_matches_for_startup(startup=startup, investors=investors)
