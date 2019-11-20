# -*- coding: utf-8 -*-

from django.urls import include, path

urlpatterns = [
    # djangorestframework
    path('', include('rest_framework.urls', namespace='rest_framework')),

    # JWT auth
    # ...

    # Local apps
    path('main/', include('server.apps.main.urls')),
]
