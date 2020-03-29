# -*- coding: utf-8 -*-

from django.urls import path

from server.apps.matchmaking.views import MatchmakingListView

app_name = 'matchmaking'

urlpatterns = [
    path(
        '',
        MatchmakingListView.as_view(),
        name='matchmaking-list',
    ),
]
