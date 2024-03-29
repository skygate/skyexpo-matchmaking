# -*- coding: utf-8 -*-

"""
This file contains all the settings that defines the development server.

SECURITY WARNING: don't run with debug turned on in production!
"""

import logging
from typing import List

from server.settings.components import config
from server.settings.components.common import INSTALLED_APPS, MIDDLEWARE
from server.settings.components.drf import REST_FRAMEWORK

DEBUG = True

ALLOWED_HOSTS = [
    config('DOMAIN_NAME'),
    config('EMULATOR_HOST'),
    'localhost',
    '127.0.0.1',
    '[::1]',
]


# Static files:
# https://docs.djangoproject.com/en/2.2/ref/settings/#std:setting-STATICFILES_DIRS

STATICFILES_DIRS: List[str] = []


# Django extensions
# django-extensions.readthedocs.io

# drf-yasg
# drf-yasg.readthedocs.io

INSTALLED_APPS += (
    'debug_toolbar',
    'nplusone.ext.django',
    'django_extensions',
    'drf_yasg',
)

MIDDLEWARE += (
    # Django debug toolbar
    # django-debug-toolbar.readthedocs.io
    'server.settings.components.ddt.FixHMLHttpRequest',
    'debug_toolbar.middleware.DebugToolbarMiddleware',
    # https://github.com/bradmontgomery/django-querycount
    # Prints how many queries were executed, useful for the APIs.
    'querycount.middleware.QueryCountMiddleware',
)

# github.com/adamchainz/django-cors-headers
CORS_ORIGIN_WHITELIST = [
    'http://localhost:3000',
]


def custom_show_toolbar(request):
    """Only show the debug toolbar to users with the superuser flag."""
    return request.user.is_superuser


# ./manage.py shell_plus --notebook
NOTEBOOK_ARGUMENTS = [
    '--ip',
    '0.0.0.0',  # noqa: S104
    '--port',
    '8888',
    '--allow-root',
    '--debug',
]

# This will make debug toolbar to work with django-csp,
# since `ddt` and DRF browsable API load some unsafe scripts.
CSP_SCRIPT_SRC = ("'self'", "'unsafe-inline'", 'blob:')
CSP_IMG_SRC = ("'self'", 'data:')
# This will load inline-style used in djangorestframework browsable API,
# and ReDoc documentation.
CSP_CONNECT_SRC = ("'self'", 'localhost:8000')
CSP_STYLE_SRC = ("'self'", "'unsafe-inline'")

# nplusone
# https://github.com/jmcarp/nplusone

# Should be the first in line:
MIDDLEWARE = (  # noqa: WPS440
    'nplusone.ext.django.NPlusOneMiddleware',
) + MIDDLEWARE

# Logging N+1 requests:
NPLUSONE_RAISE = True  # comment out if you want to allow N+1 requests
NPLUSONE_LOGGER = logging.getLogger('django')
NPLUSONE_LOG_LEVEL = logging.WARN
NPLUSONE_WHITELIST = [
    {'model': 'profile.InvestorProfile', 'field': 'company'},
    {'model': 'profile.InvestorProfile', 'field': 'angelinvestor'},
]


REST_FRAMEWORK['DEFAULT_AUTHENTICATION_CLASSES'] += [
    'rest_framework.authentication.SessionAuthentication',
]

REST_FRAMEWORK['DEFAULT_RENDERER_CLASSES'] += [
    'djangorestframework_camel_case.render.CamelCaseBrowsableAPIRenderer',
]


# drf-yasg documentation settings

SWAGGER_SETTINGS = {
    'SECURITY_DEFINITIONS': {
        'Bearer': {
            'type': 'apiKey',
            'name': 'Authorization: Bearer <jwtToken>',
            'in': 'header',
        },
    },
}
