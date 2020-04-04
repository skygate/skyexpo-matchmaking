# -*- coding: utf-8 -*-

from django.db import transaction
from djangorestframework_camel_case.parser import (
  CamelCaseJSONParser,
  CamelCaseMultiPartParser,
)
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from rest_framework import permissions, status, views
from rest_framework.request import Request
from rest_framework.response import Response

from server.apps.profile.logic.representations import (
  AngelInvestorRepresentation,
  CompanyRepresentation,
  StartupRepresentation,
)
from server.apps.profile.logic.serializers import (
  AngelInvestorCreateInputSerializer,
  AngelInvestorCreateOutputSerializer,
  AngelInvestorValidateFormStep1Serializer,
  AngelInvestorValidateFormStep2Serializer,
  CompanyCreateInputSerializer,
  CompanyCreateOutputSerializer,
  CompanyValidateFormStep1Serializer,
  CompanyValidateFormStep2Serializer,
  CompanyValidateFormStep3Serializer,
  ProfileCreateInputSerializer,
  ProfileCreateOutputSerializer,
  StartupCreateInputSerializer,
  StartupCreateOutputSerializer,
  StartupValidateFormStep1Serializer,
  StartupValidateFormStep2Serializer,
  StartupValidateFormStep3Serializer,
  UploadLogotypeInputSerializer,
  UploadLogotypeOutputSerializer,
)
from server.apps.profile.logic.services import (
  assign_profiles_to_company,
  assign_profiles_to_startup,
  create_angel_investor,
  create_company,
  create_startup,
  create_team_members_profiles,
  register_user,
  upload_logotype,
  validate_angel_investor_form_step1,
  validate_company_form_step1,
  validate_matchmaking_form,
  validate_startup_form_step1,
  validate_team_members_form,
)
from server.utils.exception_handler import ExceptionHandlerMixin


class CompanyValidateFormStep1View(ExceptionHandlerMixin, views.APIView):
    """
    Validates the data provided in the first step of the
    company registration form.
    """

    permission_classes = [permissions.AllowAny]

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


class UploadLogotypeStep1View(ExceptionHandlerMixin, views.APIView):
    """
    When a user invokes the UploadPicker and selects a picture, the frontend
    should immediately send a request to this endpoint, and the response should
    be passed to the create step as 'logotype' field.
    """

    permission_classes = [permissions.AllowAny]
    parser_classes = [CamelCaseMultiPartParser]

    @swagger_auto_schema(
        request_body=UploadLogotypeOutputSerializer,
        responses={
            status.HTTP_201_CREATED: UploadLogotypeOutputSerializer,
        },
    )
    def post(self, request: Request) -> Response:
        serializer = UploadLogotypeInputSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        path = upload_logotype(**serializer.validated_data)
        return Response(
            data=UploadLogotypeOutputSerializer({'logotype': path}).data,
            status=status.HTTP_201_CREATED,
        )


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

        validate_team_members_form(
            team_members=serializer.validated_data['team_members'],
        )

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

        validate_matchmaking_form(data=serializer.validated_data)

        return Response(status=status.HTTP_204_NO_CONTENT)


class CompanyCreateView(ExceptionHandlerMixin, views.APIView):
    """
    View used for registering a company after filling out the form.
    Firstly we create a new company, then we assign existing profiles
    to company and if some profiles don't exist, we create new ones.
    """

    permission_classes = [permissions.AllowAny]

    @swagger_auto_schema(
        request_body=CompanyCreateInputSerializer,
        responses={status.HTTP_201_CREATED: CompanyCreateOutputSerializer},
    )
    def post(self, request):
        serializer = CompanyCreateInputSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        team_members = serializer.validated_data.pop('team_members')
        company = CompanyRepresentation(**serializer.validated_data)

        with transaction.atomic():
            company_instance = create_company(company=company)
            profiles = create_team_members_profiles(team_members=team_members)
            assign_profiles_to_company(
                profiles=profiles, company=company_instance,
            )

        return Response(
            CompanyCreateOutputSerializer(company_instance).data,
            status=status.HTTP_201_CREATED,
        )


class StartupValidateFormStep1View(ExceptionHandlerMixin, views.APIView):
    """
    Validates the data provided in the first step of the
    startup registration form.
    """

    permission_classes = [permissions.AllowAny]

    @swagger_auto_schema(
        request_body=StartupValidateFormStep1Serializer,
        responses={
            status.HTTP_204_NO_CONTENT: openapi.Response(description=''),
        },
    )
    def post(self, request: Request) -> Response:
        serializer = StartupValidateFormStep1Serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        validate_startup_form_step1(data=serializer.validated_data)

        return Response(status=status.HTTP_204_NO_CONTENT)


class StartupValidateFormStep2View(ExceptionHandlerMixin, views.APIView):
    """
    Validates the data provided in the second step of the
    startup registration form.
    """

    permission_classes = [permissions.AllowAny]

    @swagger_auto_schema(
        request_body=StartupValidateFormStep2Serializer,
        responses={
            status.HTTP_204_NO_CONTENT: openapi.Response(description=''),
        },
    )
    def post(self, request: Request) -> Response:
        serializer = StartupValidateFormStep2Serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        validate_team_members_form(
            team_members=serializer.validated_data['team_members'],
        )

        return Response(status=status.HTTP_204_NO_CONTENT)


class StartupValidateFormStep3View(ExceptionHandlerMixin, views.APIView):
    """
    Validates the data provided in the third step of the
    startup registration form.
    """

    permission_classes = [permissions.AllowAny]

    @swagger_auto_schema(
        request_body=StartupValidateFormStep3Serializer,
        responses={
            status.HTTP_204_NO_CONTENT: openapi.Response(description=''),
        },
    )
    def post(self, request: Request) -> Response:
        serializer = StartupValidateFormStep3Serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        validate_matchmaking_form(data=serializer.validated_data)

        return Response(status=status.HTTP_204_NO_CONTENT)


class StartupCreateView(ExceptionHandlerMixin, views.APIView):
    """
    View used for registering a startup after filling out the form.
    Firstly we create a new startup, then we assign existing profiles
    to startup and if some profiles don't exist, we create new ones.
    """

    permission_classes = [permissions.AllowAny]
    parser_classes = [CamelCaseJSONParser]

    @swagger_auto_schema(
        request_body=StartupCreateInputSerializer,
        responses={status.HTTP_201_CREATED: StartupCreateOutputSerializer},
    )
    def post(self, request):
        serializer = StartupCreateInputSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        team_members = serializer.validated_data.pop('team_members')
        startup = StartupRepresentation(**serializer.validated_data)

        with transaction.atomic():
            startup_instance = create_startup(startup=startup)
            profiles = create_team_members_profiles(team_members=team_members)
            assign_profiles_to_startup(
                profiles=profiles, startup=startup_instance,
            )

        return Response(
            StartupCreateOutputSerializer(startup_instance).data,
            status=status.HTTP_201_CREATED,
        )


class AngelInvestorValidateFormStep1View(ExceptionHandlerMixin, views.APIView):
    """
    Validates the data provided in the first step of the
    AngelInvestor registration form.
    """

    permission_classes = [permissions.AllowAny]

    @swagger_auto_schema(
        request_body=AngelInvestorValidateFormStep1Serializer,
        responses={
            status.HTTP_204_NO_CONTENT: openapi.Response(description=''),
        },
    )
    def post(self, request: Request) -> Response:
        serializer = AngelInvestorValidateFormStep1Serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        validate_angel_investor_form_step1(data=serializer.validated_data)

        return Response(status=status.HTTP_204_NO_CONTENT)


class AngelInvestorValidateFormStep2View(ExceptionHandlerMixin, views.APIView):
    """
    Validates the data provided in the second step of the
    AngelInvestor registration form.
    """

    permission_classes = [permissions.AllowAny]

    @swagger_auto_schema(
        request_body=AngelInvestorValidateFormStep2Serializer,
        responses={
            status.HTTP_204_NO_CONTENT: openapi.Response(description=''),
        },
    )
    def post(self, request: Request) -> Response:
        serializer = AngelInvestorValidateFormStep2Serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        validate_matchmaking_form(data=serializer.validated_data)

        return Response(status=status.HTTP_204_NO_CONTENT)


class AngelInvestorCreateView(ExceptionHandlerMixin, views.APIView):
    """View used for registering an AngelInvestor after filling out the form."""

    permission_classes = [permissions.AllowAny]

    @swagger_auto_schema(
        request_body=AngelInvestorCreateInputSerializer,
        responses={
            status.HTTP_201_CREATED: AngelInvestorCreateOutputSerializer,
        },
    )
    def post(self, request):
        serializer = AngelInvestorCreateInputSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        investor = AngelInvestorRepresentation(**serializer.validated_data)

        investor_instance = create_angel_investor(angel_investor=investor)

        return Response(
            AngelInvestorCreateOutputSerializer(investor_instance).data,
            status=status.HTTP_201_CREATED,
        )


class ProfileCreateView(ExceptionHandlerMixin, views.APIView):
    """
    Registers user's profile. If a profile has been assigned to a company
    in the registration form, the account details are linked.
    """

    permission_classes = [permissions.AllowAny]

    @swagger_auto_schema(
        request_body=ProfileCreateInputSerializer,
        responses={
            status.HTTP_204_NO_CONTENT: openapi.Response(description=''),
        },
    )
    def post(self, request: Request) -> Response:
        serializer = ProfileCreateInputSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        profile = register_user(**serializer.validated_data)

        return Response(
            ProfileCreateOutputSerializer(profile).data,
            status=status.HTTP_201_CREATED,
        )
