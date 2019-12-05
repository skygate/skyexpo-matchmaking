# -*- coding: utf-8 -*-

from djangorestframework_camel_case.parser import CamelCaseMultiPartParser
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from rest_framework import permissions, status, views
from rest_framework.request import Request
from rest_framework.response import Response

from server.apps.company.logic.serializers import (
  CompanyValidateFormStep1Serializer,
  CompanyValidateFormStep2Serializer,
  CompanyValidateFormStep3Serializer,
)


class CompanyValidateFormStep1View(views.APIView):
    """
    Validates the data provided in the first step of the
    company registration form.
    """

    permission_classes = [permissions.AllowAny]
    parser_classes = [CamelCaseMultiPartParser]

    @swagger_auto_schema(
        request_body=CompanyValidateFormStep1Serializer,
        responses={
            status.HTTP_204_NO_CONTENT: openapi.Response(description=''),
        },
    )
    def post(self, request: Request) -> Response:
        serializer = CompanyValidateFormStep1Serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        return Response(status=status.HTTP_204_NO_CONTENT)


class CompanyValidateFormStep2View(views.APIView):
    """
    Validates the data provided in the second step of the
    company registration form.
    """

    permission_classes = [permissions.AllowAny]

    @swagger_auto_schema(
        request_body=CompanyValidateFormStep2Serializer,
        responses={
            status.HTTP_204_NO_CONTENT: openapi.Response(description=''),
        },
    )
    def post(self, request: Request) -> Response:
        serializer = CompanyValidateFormStep2Serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        return Response(status=status.HTTP_204_NO_CONTENT)


class CompanyValidateFormStep3View(views.APIView):
    """
    Validates the data provided in the third step of the
    company registration form.
    """

    permission_classes = [permissions.AllowAny]

    @swagger_auto_schema(
        request_body=CompanyValidateFormStep3Serializer,
        responses={
            status.HTTP_204_NO_CONTENT: openapi.Response(description=''),
        },
    )
    def post(self, request: Request) -> Response:
        serializer = CompanyValidateFormStep3Serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        return Response(status=status.HTTP_204_NO_CONTENT)
