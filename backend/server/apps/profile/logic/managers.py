# -*- coding: utf-8 -*-

from typing import TYPE_CHECKING, Any, Optional, cast

from django.contrib.auth.base_user import AbstractBaseUser, BaseUserManager

if TYPE_CHECKING:  # pragma: no cover
    from server.apps.profile.models import User  # noqa: WPS433
    BaseUserManagerType = BaseUserManager[AbstractBaseUser]
else:
    BaseUserManagerType = BaseUserManager


class UserManager(BaseUserManagerType):
    """Manager for custom user model."""

    def create_user(
        self,
        email: str,
        password: Optional[str] = None,
        **extra_fields: Any,
    ) -> 'User':
        extra_fields['is_staff'] = False
        extra_fields['is_superuser'] = False

        return self._create_user(email, password, **extra_fields)

    def create_superuser(
        self, email: str, password: str, **extra_fields: Any,
    ) -> 'User':
        extra_fields['is_staff'] = True
        extra_fields['is_superuser'] = True

        return self._create_user(email, password, **extra_fields)

    def _create_user(
        self, email: str, password: Optional[str], **extra_fields: Any,
    ) -> 'User':
        """Create and save a user with the given email and password."""
        if not email:
            raise ValueError('The given email must be set')

        email = self.normalize_email(email)
        user = cast('User', self.model(email=email, **extra_fields))
        user.set_password(password)
        user.save(using=self._db)

        return user
