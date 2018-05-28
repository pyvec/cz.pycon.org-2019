#!/usr/bin/env python
# coding=utf-8
import os
import re
import random
import datetime

from django.shortcuts import render

from pyconcz_2018.settings import BASE_DIR
from pyconcz_2018.sponsors.models import Sponsor
from pyconcz_2018.programme.models import Slot
from pyconcz_2018.announcements.models import Announcement


def get_random_pc_gradient():
    names = set()
    with open(os.path.join(BASE_DIR, 'static_src/scss/pyconcz18/_pc-gradients.scss')) as f:
        names.update(re.findall(r'pc-gradient-\w+-\w+', f.read()))
    names = list(names)
    while True:
        yield random.choice(names)


def index(request):
    return render(request, 'intermission/index.html', context=dict(interval=int(request.GET.get('interval', 10)) * 1000))


def sponsors(request, level):
    _, val, display = Sponsor.LEVELS.for_constant(level)
    sponsors = Sponsor.objects.filter(published=True, level=val)
    return render(request, 'intermission/sponsors.html', context=dict(sponsors=sponsors, level_name=display))


def up_next(request, track):
    dt_from = datetime.datetime.now()
    slot = Slot.objects.filter(date__gte=dt_from, room=track, object_id__isnull=False).order_by('date').first()
    return render(request, 'intermission/up_next.html', dict(slot=slot, pc_gradient=next(get_random_pc_gradient())))


def announcements(request):
    return render(request, 'intermission/annoucements.html',
                  dict(announcements=Announcement.objects.filter(is_public=True)[:7]))


def slido(request):
    return render(request, 'intermission/slido.html', {})
