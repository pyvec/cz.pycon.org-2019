from datetime import datetime
from django.utils import timezone

import requests
from django.template.response import TemplateResponse
from django.conf import settings

from pyconcz.programme.models import Speaker

requests_session = requests.Session()

_tickets_data_cache = None


def homepage(request):
    keynoters = Speaker.objects.filter(is_public=True, talks__is_keynote=True,
                                       talks__is_backup=False)

    return TemplateResponse(request, 'pages/homepage.html', {'keynoters': keynoters})


def retrieve_tickets_data():
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

    res = requests_session.get(releases_api, headers=headers)
    res.raise_for_status()
    releases = res.json()['releases']

    tickets = {
        'vip': {},
        'educational': {},
        'individual': {},
        'company': {},
    }

    ticket_phases = {'early bird': 'early_bird', 'regular': 'regular', 'late bird': 'late_bird'}
    for ticket in releases:
        name = [name for name in tickets if name in ticket['title'].lower()]
        phase = [phase for phase in ticket_phases if phase in ticket['title'].lower()]

        # Calculate how many tickets left for tickets with limited quantity
        if ticket['quantity'] is not None:
            ticket['tickets_left'] = ticket['quantity'] - ticket['tickets_count']

        if name and phase:
            tickets[name[0]][ticket_phases[phase[0]]] = ticket
            # all the regular tickets have the same 'end of sale' date so we extract the first
            if 'last_day_regular' not in tickets and phase[0] == 'regular':
                date_format = '%Y-%m-%dT%H:%M:%S.%f%z'
                # there is no other easy way to process a date with a colon in the timezone. So we
                # remove the colon.
                date_str = ticket['end_at'][:-3] + ticket['end_at'][-2:]
                date = datetime.strptime(date_str, date_format)
                # date which will be displayed on the site, it describes when the sale of regular
                # tickets ends
                tickets['last_day_regular'] = timezone.localtime(date)
                tickets['now'] = timezone.localtime(timezone.now())

    # we need to get the capacity and how many tickets are already sold. We use activities endpoint
    # instead of activity as it has less data and is faster
    activities_api = 'https://api.tito.io/v3/{account_id}/{event_id}/activities'.format(
        account_id=account_id,
        event_id=event_id)

    res = requests_session.get(activities_api, headers=headers)
    res.raise_for_status()
    activities = res.json()

    for activity in activities['activities']:
        # the 'Talks' activity defines our ticket capacity of the conference
        if 'Talks' in activity['name']:
            tickets['sold'] = activity['allocation_count']
            tickets['capacity'] = activity['capacity']
            tickets['left'] = tickets['capacity'] - tickets['sold']
            break

    return tickets


def get_cached_tickets_data():
    global _tickets_data_cache
    if not _tickets_data_cache:
        _tickets_data_cache = retrieve_tickets_data()
    return {**_tickets_data_cache, 'cached': True}


def get_fresh_tickets_data():
    global _tickets_data_cache
    _tickets_data_cache = retrieve_tickets_data()
    return {**_tickets_data_cache, 'cached': False}


def tickets_index(request):
    tickets = get_cached_tickets_data()
    return TemplateResponse(request, 'pages/tickets.html', {'tickets': tickets})


def tickets_ajax_content(request):
    tickets = get_fresh_tickets_data()
    return TemplateResponse(request, 'pages/tickets_ajax_content.html', {'tickets': tickets})
