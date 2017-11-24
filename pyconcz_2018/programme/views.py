from itertools import chain

from django.db.models import Q
from django.template.response import TemplateResponse
from django.shortcuts import get_object_or_404
from django.conf import settings

from .models import Speaker, Slot, EndTime, Talk, Workshop


def speakers_list(request, type):
    speakers = (Speaker.objects.filter(is_public=True)
                .exclude(**{type: None})
                .prefetch_related(type)
                .order_by('full_name'))

    return TemplateResponse(
        request,
        template='programme/{}_list.html'.format(type),
        context={'speakers': speakers}
    )


def talk_detail(request, type, talk_id):
    MODEL_MAP = dict(talk=Talk, workshop=Workshop)
    obj = get_object_or_404(MODEL_MAP.get(type), id=talk_id)

    return TemplateResponse(
        request,
        template='programme/{}_detail.html'.format(type),
        context={'talk': obj}
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
            'content_object__{}s'.format(ct)
        )
        .annotate(
            date_end=EndTime()
        )
        .order_by('date', 'room')
    )


def schedule(request):
    slots = chain(
        _prefetch_generic('talk'),
        _prefetch_generic('workshop')
    )

    return TemplateResponse(
        request,
        template='programme/slot_schedule.html',
        context={
            'slots': slots,
            'ALL_ROOMS': settings.ALL_ROOMS
        }
    )
