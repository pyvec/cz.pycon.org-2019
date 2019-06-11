#!/usr/bin/env python
# coding=utf-8
import datetime

from django.template.response import TemplateResponse

from pyconcz.sponsors.models import Sponsor
from pyconcz.programme.models import Slot
from pyconcz.announcements.models import Announcement


def index(request):
    return TemplateResponse(
        request,
        template='intermission/index.html',
        context={
            'interval': int(request.GET.get('interval', 10)) * 1000,
        }
    )


def sponsors(request, level):
    _, val, display = Sponsor.LEVELS.for_constant(level)
    sponsors = Sponsor.objects.filter(published=True, level=val)

    return TemplateResponse(
        request,
        template='intermission/sponsors.html',
        context={
            'sponsors': sponsors,
            'level_name': display,
            'level_slug': level,
        }
    )


def up_next(request, track):
    dt_from = datetime.datetime.now()
    slot = Slot.objects.filter(
        start__gte=dt_from, room=track, object_id__isnull=False
    ).order_by('start').first()

    return TemplateResponse(
        request,
        template='intermission/up_next.html',
        context={
            'slot': slot,
        }
    )


def announcements(request):
    return TemplateResponse(
        request,
        template='intermission/annoucements.html',
        context={
            'announcements': Announcement.objects.filter(is_public=True)[:7],
        }
    )


def slido(request):
    return TemplateResponse(
        request,
        template='intermission/slido.html',
    )
