# -*- coding: utf-8 -*-


def FixHMLHttpRequest(get_response):  # noqa: N802
    """ISSUE: https://github.com/jazzband/django-debug-toolbar/issues/998"""
    def middleware(request):  # noqa: WPS430
        """
        When `POST`ing data from the DRF browsable API, it will set the
        header `X_REQUESTED_WITH: XMLHttpRequest`. (Not sure if the browser
        adds that header of if DRF's front-end does, but that doesn't matter,
        the header is there.) It's a little contradictory that the header is
        there since the browser also requests that the response be 'text/html'.
        Anyway, that's fine except for one thing. Django Debug Toolbar will
        not show the debug toolbar whenever that header is set on the request!

        My workaround is to remove that header whenever the request explicitly
        asks for 'text/html'. Again, in my opinion, that header doesn't really
        make sense anyway when the browser wants to receive HTML back.

        This makes is so that when you POST data from the DRF browsable API,
        you can still see the Django Debug Toolbar. It maintains the desired
        behavior of _not_ showing the toolbar when you POST from Javascript
        to obtain JSON data
        """
        if 'text/html' in request.META.get('HTTP_ACCEPT', ''):
            if request.META.get('HTTP_X_REQUESTED_WITH', '') == 'XMLHttpRequest':  # noqa: E501
                del request.META['HTTP_X_REQUESTED_WITH']  # noqa: WPS420

        response = get_response(request)

        return response  # noqa: WPS331

    return middleware


DEBUG_TOOLBAR_CONFIG = {
    'SHOW_TOOLBAR_CALLBACK':
        'server.settings.environments.development.custom_show_toolbar',
}
