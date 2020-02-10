from django.http import HttpResponse
from django.template.response import TemplateResponse
from django.shortcuts import get_object_or_404
from django.views.decorators.csrf import csrf_exempt

import requests

from .models import Speaker, Slot, EndTime, Talk, Workshop
from django.conf import settings


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


@csrf_exempt
def workshops_refresh_tickets(request):
    secret_key = settings.TITO_SECRET_KEY
    account_id = settings.TITO_ACCOUNT_NAME
    event_id = settings.TITO_EVENT_NAME

    releases_api = 'https://api.tito.io/v3/{account_id}/{event_id}/releases'.format(
        account_id=account_id,
        event_id=event_id)

    headers = {
        'Authorization': 'Token token={secret_key}'.format(secret_key=secret_key),
        'Accept': 'application/json',
    }

    requests_session = requests.Session()
    res = requests_session.get(releases_api, headers=headers)
    res.raise_for_status()
    releases = res.json()['releases']

    output = ''

    for ticket in releases:
        if ' Workshop:' in ticket['title']:
            workshop = Workshop.objects.get(tito_id=ticket['slug'])
            workshop.free_tickets_count = ticket['quantity'] - ticket['tickets_count']
            workshop.is_sold_out = ticket['sold_out']
            workshop.save()
            output += 'workshop {id} - registered {registered}, all: {all_tickets}, sold out: {sold_out} ({title})<br>'.format(
                id=workshop.id,
                title=workshop.title,
                registered=ticket['tickets_count'],
                all_tickets=ticket['quantity'],
                sold_out=workshop.is_sold_out
            )

    return HttpResponse(output)


def session_detail(request, type, session_id):
    MODEL_MAP = dict(talk=Talk, workshop=Workshop, sprint=Workshop)
    session = get_object_or_404(MODEL_MAP.get(type), id=session_id, is_public=True, is_backup=False)

    slot = Slot.objects.filter(
        content_type__app_label='programme',
        content_type__model=dict(talk='talk', workshop='workshop', sprint='workshop').get(type),
        object_id=session_id,
    ).first()

    session_previous = MODEL_MAP.get(type).objects.filter(
        is_public=True, is_backup=False, order__lt=session.order).order_by('order').last()

    if not session_previous:  # at the first session provide the last one as previous
        session_previous = MODEL_MAP.get(type).objects.filter(
            is_public=True, is_backup=False).order_by('order').last()

    session_next = MODEL_MAP.get(type).objects.filter(
        is_public=True, is_backup=False, order__gt=session.order).order_by('order').first()

    if not session_next:  # at the last session provide the first one as next
        session_next = MODEL_MAP.get(type).objects.filter(
            is_public=True, is_backup=False).order_by('order').first()

    # the following code expects
    # - there are no talks or workshops with
    #   is_public=False and/or is_backup=True in the programme/slots (schedule)
    # - conference is shorter than a month which allows simpler “is it the same day?“ comparison

    return TemplateResponse(
        request,
        template='programme/{}_detail.html'.format(type),
        context={
            'session': session,
            'other_sessions': {
                'previous': session_previous,
                'next': session_next,
                'parallel': Slot.objects.filter(
                    start__gte=slot.start, start__lt=slot.end).exclude(room=slot.room).order_by('room', 'start'),
                'following_parallel': Slot.objects.filter(
                    start__gte=slot.end, start__day=slot.start.day).exclude(room=slot.room).order_by('room', 'start'),
                'following': Slot.objects.filter(
                    start__gte=slot.end, start__day=slot.start.day, room=slot.room).order_by('start').first(),
            },
            'slot': slot,
        }
    )


def talk_frame(request, frame_type, session_id):
    return TemplateResponse(
        request,
        template='programme/talk_frame_{}.html'.format(frame_type),
        context={
            'session': get_object_or_404(Talk, id=session_id),
        }
    )


def other_frame(request, frame_type):
    return TemplateResponse(
        request,
        template='programme/other_frame_{}.html'.format(frame_type)
    )


def schedule(request):
    slots = (
        Slot.objects.all().filter(
            content_type__app_label='programme',
            content_type__model__in=['talk', 'workshop', 'utility']
        ).prefetch_related(
            'content_object',
        ).annotate(
            start_end=EndTime()
        ).order_by('start', 'room')
    )

    domain = '/'.join(request.build_absolute_uri().split('/')[:3])
    return TemplateResponse(
        request,
        template='programme/schedule.html',
        context={
            'slots': slots,
            'domain': domain,
        }
    )
