# -*- coding: utf-8 -*-

import pytest
from rest_framework import status
from rest_framework.reverse import reverse

from tests.factories import CompanyFactory, ProfileFactory, StartupFactory


@pytest.mark.django_db
def test_matchmaking_list(api_client):
    """
    Ensures that 'matchmaking:matchmaking-list' endpoint returns match
    objects for investors and startups members.
    """
    # GIVEN logged investor
    profile = ProfileFactory.create()
    CompanyFactory.create(profiles=[profile])
    api_client.force_login(profile.user)
    # WHEN get request to matchmaking-list
    response = api_client.get(reverse('matchmaking:matchmaking-list'))
    # THEN return matchmaking list data
    assert response.status_code == status.HTTP_200_OK

    # GIVEN logged startup member
    profile = ProfileFactory.create()
    StartupFactory.create(profiles=[profile])
    api_client.force_login(profile.user)
    # WHEN get request to matchmaking-list
    response = api_client.get(reverse('matchmaking:matchmaking-list'))
    # THEN return matchmaking list data
    assert response.status_code == status.HTTP_200_OK
