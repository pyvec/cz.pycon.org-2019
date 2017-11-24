#!/usr/bin/env python
# coding=utf-8
import datetime

from django.shortcuts import render

from pyconcz_2018.sponsors.models import Sponsor
from pyconcz_2018.programme.models import Slot
from pyconcz_2018.announcements.models import Announcement


def index(request):
    return render(request, 'intermission/index.html', context={})


def sponsors(request, level):
    return render(request, 'intermission/sponsors.html',
                  context=dict(sponsors=Sponsor.objects.filter(published=True, level=level)))


def up_next(request, track):
    dt_from = datetime.datetime.now()
    slot = Slot.objects.filter(date__gte=dt_from, room=track, object_id__isnull=False).order_by('date').first()

    return render(request, 'intermission/up_next.html', dict(slot=slot))


def announcements(request):
    return render(request, 'intermission/annoucements.html',
                  dict(announcements=Announcement.objects.all()[:7]))


def workshop_sinners(request):
    return render(request, 'intermission/workshop_sinners.html', context={})
