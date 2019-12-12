# -*- coding: utf-8 -*-

from django.urls import include, path
from rest_framework_simplejwt.views import (
  TokenObtainPairView,
  TokenRefreshView,
)

urlpatterns = [
    # djangorestframework
    path('', include('rest_framework.urls', namespace='rest_framework')),

    # JWT auth
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),

    # Local apps
    path('companies/', include('server.apps.company.urls')),
]
