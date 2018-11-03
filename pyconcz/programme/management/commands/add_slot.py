import datetime

from django.conf import settings
from django.core.management.base import BaseCommand
from django.utils import timezone

from pyconcz.programme.models import Slot


class Command(BaseCommand):

    def add_arguments(self, parser):
        parser.add_argument('date', help='YYYY-MM-DD')
        parser.add_argument('description', help='slot description')
        parser.add_argument('room', type=int, choices=[one[0] for one in settings.ALL_ROOMS],
                            help=settings.ALL_ROOMS)
        parser.add_argument('count', type=int, default=1, help='slot copies')

    def handle(self, *args, **options):
        for one in range(options['count']+1):
            date = datetime.datetime.strptime(options['date'], '%Y-%m-%d')
            Slot.objects.create(date=timezone.make_aware(
                datetime.datetime(date.year, date.month, date.day),
                timezone.get_current_timezone()),
                description=options['description'],
                room=options['room'],
            )
