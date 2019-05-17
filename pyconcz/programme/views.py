from itertools import chain

from django.db.models import Q
from django.template.response import TemplateResponse
from django.shortcuts import get_object_or_404
from django.conf import settings

from .models import Speaker, Slot, EndTime, Talk, Workshop


def preview(request):
    speakers = Speaker.objects.prefetch_related('talks', 'workshops').order_by('full_name')

    return TemplateResponse(
        request,
        template='programme/preview.html',
        context={'speakers': speakers}
    )


def talks_list(request):
    nonbackup_talks = Talk.objects.filter(is_backup=False)
    talks = nonbackup_talks.filter(is_public=True, is_backup=False).order_by('order')
    more_to_come = nonbackup_talks.filter(is_public=False).exists()

    return TemplateResponse(
        request,
        template='programme/talks_list.html',
        context={'sessions': talks, 'more_to_come': more_to_come}
    )


def workshops_list(request):
    nonbackup_workshops = Workshop.objects.filter(is_backup=False)
    workshops = nonbackup_workshops.filter(is_public=True, is_backup=False).order_by('order')
    more_to_come = nonbackup_workshops.filter(is_public=False).exists()

    return TemplateResponse(
        request,
        template='programme/workshops_list.html',
        context={'sessions': workshops, 'more_to_come': more_to_come}
    )


def session_detail(request, type, session_id):
    MODEL_MAP = dict(talk=Talk, workshop=Workshop, sprint=Workshop)
    session = get_object_or_404(MODEL_MAP.get(type), id=session_id, is_public=True, is_backup=False)

    session_previous = MODEL_MAP.get(type).objects.filter(
        is_public=True, is_backup=False, order__lt=session.order).order_by('order').last()

    if not session_previous:
        session_previous = MODEL_MAP.get(type).objects.filter(
            is_public=True, is_backup=False).order_by('order').last()

    session_next = MODEL_MAP.get(type).objects.filter(
        is_public=True, is_backup=False, order__gt=session.order).order_by('order').first()

    if not session_next:
        session_next = MODEL_MAP.get(type).objects.filter(
            is_public=True, is_backup=False).order_by('order').first()

    return TemplateResponse(
        request,
        template='programme/{}_detail.html'.format(type),
        context={
            'session': session,
            'session_previous': session_previous,
            'session_next': session_next
        }
    )


def _prefetch_generic(ct):
    if ct == 'talk':
        lookup = {'date__lt': settings.WORKSHOPS_DATES[0]}
    else:
        lookup = {'date__gte': settings.WORKSHOPS_DATES[0]}

    return (
        Slot.objects.all()
            .filter(
            Q(
                content_type__app_label='programme',
                content_type__model=ct,
            ) | ~Q(description=None),
            **lookup
        )
            .prefetch_related(
            'content_object',
        )
            .annotate(
            date_end=EndTime()
        )
            .order_by('date', 'room')
    )


def schedule(request):
    slots = chain(
        _prefetch_generic('talk'),
        _prefetch_generic('workshop'),
        _prefetch_generic('utility'),
    )
    domain = "/".join(request.build_absolute_uri().split("/")[:3])
    return TemplateResponse(
        request,
        template='programme/slot_schedule.html',
        context={
            'slots': slots,
            'ALL_ROOMS': settings.ALL_ROOMS,
            'domain': domain,
        }
    )
