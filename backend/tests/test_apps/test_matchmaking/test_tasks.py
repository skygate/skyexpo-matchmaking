# -*- coding: utf-8 -*-

from unittest.mock import patch

from server.apps.matchmaking.logic.tasks import match_startup_with_investors


@patch('server.apps.matchmaking.logic.tasks.create_matches_for_startup')
def test_match_startup_with_investors(
    create_matches_for_startup, startup, company,
):
    # WHEN match_startup_with_investors is triggered
    match_startup_with_investors(startup_id=startup.pk)
    # THEN trigger create_matches_for_startup
    create_matches_for_startup.assert_called()
