# -*- coding: utf-8 -*-

import pytest
from django.core.exceptions import ValidationError

from server.apps.profile.logic.services import check_for_duplicated_emails


def test_check_for_duplicated_emails():
    """Ensures that function checks for duplicates correctly."""
    emails = ['marcin@jos.pl', 'marcin@jos.pl']

    with pytest.raises(
        ValidationError, match='You cannot enter the same email twice.',
    ):
        check_for_duplicated_emails(emails=emails)
