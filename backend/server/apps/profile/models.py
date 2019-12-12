# -*- coding: utf-8 -*-

from django.contrib.auth.base_user import AbstractBaseUser
from django.contrib.auth.models import PermissionsMixin
from django.db import models
from django.utils import timezone
from phonenumber_field.modelfields import PhoneNumberField

from server.apps.company.models import Company
from server.apps.profile.logic.managers import UserManager
from server.apps.profile.logic.querysets import ProfileQuerySet


class User(AbstractBaseUser, PermissionsMixin):
    """The Custom user model used only for authentication purposes."""

    email = models.EmailField(unique=True, db_index=True)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)

    USERNAME_FIELD = 'email'  # noqa: WPS115

    objects = UserManager()


class Profile(models.Model):
    """Represents the user's profile."""

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    date_joined = models.DateTimeField(default=timezone.now)
    phone_number = PhoneNumberField(blank=True)
    company = models.ForeignKey(
        Company,
        on_delete=models.SET_NULL,
        db_index=True,
        null=True,
        blank=True,
        related_name='profiles',
        default=None,
    )

    objects = ProfileQuerySet.as_manager()

    class Meta:
        constraints = [
            models.CheckConstraint(
                check=~models.Q(name=''), name='non_empty_name',
            ),
        ]

    def __str__(self) -> str:
        return str(self.user)
