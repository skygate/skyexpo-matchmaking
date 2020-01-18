# -*- coding: utf-8 -*-

from django.core import validators
from django.db import models

from server.apps.profile.models import InvestorProfile, Startup


class Match(models.Model):
    """

    """

    startup = models.ForeignKey(Startup, on_delete=models.CASCADE)
    investor = models.ForeignKey(InvestorProfile, on_delete=models.CASCADE)
    result = models.PositiveSmallIntegerField(
        validators=[
            validators.MinValueValidator(0),
            validators.MaxValueValidator(100),
        ],
    )
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = 'Matches'

    def __str__(self) -> str:
        return f'{str(self.startup)} - {str(self.investor)}: {self.result}'
