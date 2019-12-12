# -*- coding: utf-8 -*-

from django.urls import path

from server.apps.profile.views import CompanyCreateView

app_name = 'profile'

urlpatterns = [
    path(
        'companies/',
        CompanyCreateView.as_view(),
        name='company-create',
    ),
]
