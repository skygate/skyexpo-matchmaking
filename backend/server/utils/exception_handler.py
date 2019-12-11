# -*- coding: utf-8 -*-

import typing
from typing import Any

from django.core.exceptions import ValidationError
from rest_framework import exceptions as rest_exceptions
# TODO: add typing (use protocols for mixins), refactor and add tests
from rest_framework.response import Response

MessageDictType = typing.Dict[str, typing.List[str]]

if typing.TYPE_CHECKING:
    from rest_framework.views import APIView  # noqa: WPS433
    _Base = APIView
else:
    _Base = object


def _get_first_matching_attr(obj: Any, *attrs: Any, default=None):
    for attr in attrs:
        if hasattr(obj, attr):  # noqa: WPS421
            return getattr(obj, attr)

    return default


def _get_error_message(
    exc: typing.Union[Exception, ValidationError, PermissionError, ValueError],
) -> typing.Union[MessageDictType, str]:
    if hasattr(exc, 'message_dict'):  # noqa: WPS421
        return typing.cast(ValidationError, exc).message_dict
    error_msg = _get_first_matching_attr(exc, 'message', 'messages')

    if isinstance(error_msg, list):
        error_msg = ', '.join(error_msg)

    if error_msg is None:
        error_msg = str(exc)

    return error_msg


class ExceptionHandlerMixin(_Base):
    """
    Mixin that transforms Django and Python exceptions into rest_framework ones.
    Without the mixin, they return 500 status code which is not desired.
    """

    expected_exceptions = {
        ValueError: rest_exceptions.ValidationError,
        ValidationError: rest_exceptions.ValidationError,
        PermissionError: rest_exceptions.PermissionDenied,
    }

    def handle_exception(self, exc: Exception) -> Response:
        if isinstance(exc, tuple(self.expected_exceptions.keys())):
            drf_exception_class = self.expected_exceptions[exc.__class__]
            drf_exception = drf_exception_class(_get_error_message(exc))

            return super().handle_exception(drf_exception)

        return super().handle_exception(exc)
