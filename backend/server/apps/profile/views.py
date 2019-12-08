# -*- coding: utf-8 -*-

from django.db import transaction
from djangorestframework_camel_case.parser import CamelCaseMultiPartParser, CamelCaseJSONParser
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from rest_framework import permissions, status, views
from rest_framework.request import Request
from rest_framework.response import Response

from server.apps.profile.logic.representations import CompanyRepresentation, TeamMembersRepresentation
from server.apps.profile.logic.serializers import (
    CompanyValidateFormStep1Serializer,
    CompanyValidateFormStep2Serializer,
    CompanyValidateFormStep3Serializer,
    CompanyCreateInputSerializer, CompanyCreateOutputSerializer)
from server.apps.profile.logic.services import (
    validate_company_form_step1,
    validate_company_form_step2,
    validate_company_form_step3,
    create_company, create_profiles)
from server.utils.exception_handler import ExceptionHandlerMixin


class CompanyValidateFormStep1View(ExceptionHandlerMixin, views.APIView):
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

        validate_company_form_step1(data=serializer.validated_data)

        return Response(status=status.HTTP_204_NO_CONTENT)


class CompanyValidateFormStep2View(ExceptionHandlerMixin, views.APIView):
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

        validate_company_form_step2(data=serializer.validated_data)

        return Response(status=status.HTTP_204_NO_CONTENT)


class CompanyValidateFormStep3View(ExceptionHandlerMixin, views.APIView):
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

        validate_company_form_step3(data=serializer.validated_data)

        return Response(status=status.HTTP_204_NO_CONTENT)


class CompanyCreateView(ExceptionHandlerMixin, views.APIView):
    """View used for registering a company after filling out the form."""

    permission_classes = [permissions.AllowAny]
    parser_classes = [CamelCaseMultiPartParser, CamelCaseJSONParser]

    @swagger_auto_schema(
        request_body=CompanyCreateInputSerializer,
        responses={status.HTTP_201_CREATED: CompanyCreateOutputSerializer},
    )
    def post(self, request):
        serializer = CompanyCreateInputSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        team_members = TeamMembersRepresentation(
            serializer.validated_data.pop('team_members'),
        )
        company = CompanyRepresentation(**serializer.validated_data)

        with transaction.atomic():
            company_instance = create_company(company=company)
            create_profiles(
                team_members=team_members,
                company=company_instance,
            )

        return Response(
            CompanyCreateOutputSerializer(company_instance).data,
            status=status.HTTP_201_CREATED,
        )
