# -*- coding: utf-8 -*-
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from rest_framework import views, status, permissions
from rest_framework.response import Response

from server.apps.company.logic.serializers import CompanyValidateFormStep1Serializer


class CompanyValidateFormStep1View(views.APIView):
    """
    Validates the data provided in the first step of the
    company registration form.
    """

    permission_classes = [permissions.AllowAny]

    @swagger_auto_schema(
        request_body=CompanyValidateFormStep1Serializer,
        responses={
            status.HTTP_204_NO_CONTENT: openapi.Response(description='')
        }
    )
    def post(self, request):
        serializer = CompanyValidateFormStep1Serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        return Response(status=status.HTTP_204_NO_CONTENT)
