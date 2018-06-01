#!/usr/bin/env python
# coding=utf-8
import random
import datetime

from django.shortcuts import render

from pyconcz_2018.settings import BASE_DIR
from pyconcz_2018.sponsors.models import Sponsor
from pyconcz_2018.programme.models import Slot
from pyconcz_2018.announcements.models import Announcement


gradients = [
    'pc-gradient-orchid-ginger',
    'pc-gradient-orchid-violetred',
    'pc-gradient-orchid-yellow',
    'pc-gradient-orchidred-yellow',
    'pc-gradient-orchid-lime',
    'pc-gradient-violetred-lime',
    'pc-gradient-yellow-lime',
    'pc-gradient-orchid-mint',
    'pc-gradient-orchidred-cyan',
    'pc-gradient-yellow-cyan',
    'pc-gradient-orchid-blue',
    'pc-gradient-yellow-blue',
    'pc-gradient-orchidred-navy',
    'pc-gradient-orchid-orchidred',
    'pc-gradient-blue-cyan',
    'pc-gradient-navy-cyan',
]


def index(request):
    return render(request, 'intermission/index.html', context=dict(interval=int(request.GET.get('interval', 10)) * 1000))


def sponsors(request, level):
    _, val, display = Sponsor.LEVELS.for_constant(level)
    sponsors = Sponsor.objects.filter(published=True, level=val)
    return render(request, 'intermission/sponsors.html',
                  context=dict(sponsors=sponsors, level_name=display, level_slug=level))


def up_next(request, track):
    dt_from = datetime.datetime.now()
    slot = Slot.objects.filter(date__gte=dt_from, room=track, object_id__isnull=False).order_by('date').first()
    pc_gradient = random.choice(gradients) + random.choice(['', '-reversed'])
    return render(request, 'intermission/up_next.html', dict(slot=slot, pc_gradient=pc_gradient))


def announcements(request):
    return render(request, 'intermission/annoucements.html',
                  dict(announcements=Announcement.objects.filter(is_public=True)[:7]))


def slido(request):
    return render(request, 'intermission/slido.html', {})
