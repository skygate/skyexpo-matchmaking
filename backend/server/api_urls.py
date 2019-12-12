# -*- coding: utf-8 -*-

from django.urls import include, path
from rest_framework_simplejwt.views import (
  TokenObtainPairView,
  TokenRefreshView,
)

from server.apps.profile.views import (
  CompanyValidateFormStep1View,
  CompanyValidateFormStep2View,
  CompanyValidateFormStep3View,
)

urlpatterns = [
    # djangorestframework
    path('', include('rest_framework.urls', namespace='rest_framework')),

    # JWT auth
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),

    # Local apps
    path('profiles/', include('server.apps.profile.urls')),

    # Web-app forms
    path(
        'form/company/step-1/',
        CompanyValidateFormStep1View.as_view(),
        name='validate-form-company-step-1',
    ),
    path(
        'form/company/step-2/',
        CompanyValidateFormStep2View.as_view(),
        name='validate-form-company-step-2',
    ),
    path(
        'form/company/step-3/',
        CompanyValidateFormStep3View.as_view(),
        name='validate-form-company-step-3',
    ),
]
