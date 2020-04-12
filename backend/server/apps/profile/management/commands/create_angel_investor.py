# -*- coding: utf-8 -*-

from prettytable import PrettyTable

from server.apps.profile.models import AngelInvestor, User
from server.utils.fixture_command import FixtureCommand
from tests.factories import AngelInvestorFactory, DEFAULT_PASSWORD


class Command(FixtureCommand):
    help = '...'

    def _load_fixtures(self, options) -> ...:
        return AngelInvestorFactory.create_batch(options['batch'])

    def _clean_db(self) -> int:
        ids = AngelInvestor.objects.all().values_list('profile__user', flat=True)
        count = ids.count()

        User.objects.filter(id__in=ids).delete()
        return count

    def _pretty_print(self, objects) -> None:
        table = PrettyTable()
        table.field_names = ['ID', 'E-mail', 'Password']

        for obj in objects:
            table.add_row([obj.pk, obj.profile.user.email, DEFAULT_PASSWORD])

        print(table)
