from django.conf import settings
from django.core.management.base import BaseCommand

from pyconcz.programme.models import Slot


class Command(BaseCommand):

    def handle(self, *args, **options):
        slots = Slot.objects.all()
        slots_per_room = {}
        all_ok = True
        conference_days = settings.TALKS_DATES + settings.WORKSHOPS_DATES

        # Move all slots to dictionary per room name
        for slot in slots:
            room_name = slot.get_room_display()
            if room_name not in slots_per_room:
                slots_per_room[room_name] = [slot]
            else:
                slots_per_room[room_name].append(slot)

        # Validation for every room
        for room_name, slots_in_room in slots_per_room.items():
            slots_in_room.sort(key=lambda s: s.start)
            print('Validating ', room_name, '…')

            # Check for every slot
            for index, slot in enumerate(slots_in_room):

                # Every slot should start and end in conference days
                if slot.start.date() not in conference_days or \
                        slot.end.date() not in conference_days:
                    print(self.style.ERROR('Slot outside conference days:'))
                    all_ok = False

                # Every slot should have some object associated
                if slot.content_object is None:
                    print(self.style.ERROR('Slot without content:'))
                    all_ok = False

                # Every slot should end before the next one start
                try:
                    next_slot = slots_in_room[index + 1]
                except IndexError:
                    pass
                else:
                    if next_slot.start < slot.end:
                        print(self.style.ERROR('Following two slots overlap:'))
                        all_ok = False

                print(slot.start, slot.end, slot.content_object)

        if all_ok:
            print(self.style.SUCCESS('Programme seems to be valid'))
        else:
            print(self.style.ERROR('Errors found!'))
