# -*- coding: utf-8 -*-

from django.urls import path

from server.apps.profile.views import (
  AngelInvestorCreateView,
  CompanyCreateView,
  ProfileCreateView,
  StartupCreateView,
)

app_name = 'profile'

urlpatterns = [
    path(
        'companies/',
        CompanyCreateView.as_view(),
        name='company-create',
    ),
    path(
        'startups/',
        StartupCreateView.as_view(),
        name='startup-create',
    ),
    path(
        'investors/',
        AngelInvestorCreateView.as_view(),
        name='investor-create',
    ),
    path(
        '',
        ProfileCreateView.as_view(),
        name='profile',
    ),
]
