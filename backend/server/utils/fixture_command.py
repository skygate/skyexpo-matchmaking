from django.core.management import BaseCommand, CommandError
from django.db import transaction, IntegrityError
from factory.random import reseed_random


class FixtureCommand(BaseCommand):
    """..."""

    def add_arguments(self, parser):
        parser.add_argument(
            '--clean',
            action='store_true',
            help='...',
        )

        parser.add_argument(
            '--batch',
            action='store',
            help='...',
            default=1,
            type=int,
        )

        parser.add_argument(
            '--seed',
            help='...',
            default='skyexpo',
            type=str,
        )

    def handle(self, *args, **options):
        try:
            with transaction.atomic():
                if options['clean']:
                    count = self._clean_db()
                    self.stdout.write(
                        f'Removed \'{count}\' object(s) from the database.',
                    )

                self._set_seed(options['seed'])

                objects = self._load_fixtures(options)
                self._pretty_print(objects)
                self.stdout.write(
                    self.style.SUCCESS('Fixtures loaded successfully.'),
                )
        except Exception as e:
            if isinstance(e, IntegrityError) and not options['clean']:
                raise CommandError(
                    f'{e} \nTry to run this command with --clean option.')
            raise CommandError(e)

    def _set_seed(self, seed):
        reseed_random(seed)
        self.stdout.write(f'Using seed \'{seed}\' for randomization.')

    def _clean_db(self) -> int:
        """..."""
        raise NotImplementedError

    def _load_fixtures(self, options: ...):
        """..."""
        raise NotImplementedError

    def _pretty_print(self, objects: ...) -> None:
        """..."""
        raise NotImplementedError
