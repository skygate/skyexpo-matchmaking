# -*- coding: utf-8 -*-

"""
Main URL mapping configuration file.
Include other URLConfs from external apps using method `include()`.
It is also a good practice to keep a single URL to the root index page.
This examples uses Django's default media
files serving technique in development.
"""

from django.conf import settings
from django.contrib import admin
from django.urls import include, path
from health_check import urls as health_urls
from rest_framework import permissions

admin.autodiscover()


urlpatterns = [
    # Apps:
    path('api/', include('server.api_urls')),

    # Health checks:
    path('health/', include(health_urls)),  # noqa: DJ05

    # django-admin:
    path('admin/', admin.site.urls),
]

if settings.DEBUG:  # pragma: no cover
    import debug_toolbar  # noqa: WPS433
    from django.conf.urls.static import static  # noqa: WPS433
    from drf_yasg import openapi    # noqa: WPS433
    from drf_yasg.views import get_schema_view  # noqa: WPS433

    schema_view = get_schema_view(
        openapi.Info(
            title='skyexpo 2020 matchmaking app',
            default_version='v1',
            description='The matchmaking app for skyexpo 2020.',
            contact=openapi.Contact(email='marcin.josinski@skygate.io'),
        ),
        public=True,
        permission_classes=(permissions.AllowAny,),
    )

    urlpatterns = [
        # URLs specific only to django-debug-toolbar:
        path('__debug__/', include(debug_toolbar.urls)),  # noqa: DJ05

        # ReDoc documentation:
        path(
            'redoc/',
            schema_view.with_ui('redoc', cache_timeout=0),
            name='schema-redoc',
        ),
    ] + urlpatterns + static(
        # Serving media files in development only:
        settings.MEDIA_URL,
        document_root=settings.MEDIA_ROOT,
    )
