from datetime import datetime

import requests
from django.template.response import TemplateResponse
from django.conf import settings

from pyconcz.programme.models import Speaker


def homepage(request):
    keynoters = Speaker.objects.filter(is_public=True, talks__is_keynote=True,
                                       talks__is_backup=False)

    return TemplateResponse(request, 'pages/homepage.html', {'keynoters': keynoters})

def tickets_index(request):
    secret_key = settings.TITO_SECRET_KEY
    account_id = settings.TITO_ACCOUNT_NAME
    event_id = settings.TITO_EVENT_NAME

    releases_api = "https://api.tito.io/v3/{account_id}/{event_id}/releases".format(
        account_id=account_id,
        event_id=event_id)

    headers = {
        "Authorization": "Token token={secret_key}".format(secret_key=secret_key),
        "Accept": "application/json",
    }

    res = requests.get(releases_api, headers=headers)

    res.raise_for_status()

    tickets_md = res.json()

    tickets = {
        "vip": {},
        "educational": {},
        "individual": {},
        "company": {},
    }

    ticket_phases = {"early bird": "early_bird", "regular": "regular", "late bird": "late_bird"}
    for ticket in tickets_md["releases"]:
        name = [name for name in tickets
                if name in ticket["title"].lower()]
        phase = [phase for phase in ticket_phases
                 if phase in ticket["title"].lower()]

        # Calculate how many tickets left for tickets with limited quantity
        if ticket["quantity"] is not None:
            ticket["tickets_left"] = ticket["quantity"] - ticket["tickets_count"]

        if name and phase:
            tickets[name[0]][ticket_phases[phase[0]]] = ticket
            # all the regular tickets have the same "end of sale" date so we extract the first
            if "last_day_regular" not in tickets and phase[0] == "regular":
                date_format = '%Y-%m-%dT%H:%M:%S.%f%z'
                # there is no other easy way to process a date with a colon in the timezone. So we
                # remove the colon.
                date_str = ticket["end_at"][:-3] + ticket["end_at"][-2:]
                date = datetime.strptime(date_str, date_format)
                # date which will be displayed on the site, it describes when the sale of regular
                # tickets ends
                tickets["last_day_regular_date"] = date
                # number which the logic in the template works with. it determines when what
                # changes should happen (month and day put together). Previously this was hardcoded
                # into the template.
                tickets["last_day_regular"] = int(date.strftime("%-m%d"))

    # we need to get the capacity and how many tickets are already sold. We use activities endpoint
    # instead of activity as it has less data and is faster
    activities_api = "https://api.tito.io/v3/{account_id}/{event_id}/activities".format(
        account_id=account_id,
        event_id=event_id)

    res = requests.get(activities_api, headers=headers)

    res.raise_for_status()

    activities = res.json()

    for activity in activities["activities"]:
        # the 'Talks' activity defines our ticket capacity of the conference
        if "Talks" in activity["name"]:
            tickets["sold"] = activity["allocation_count"]
            tickets["capacity"] = activity["capacity"]
            break

    return TemplateResponse(request, 'pages/tickets.html', {"tickets": tickets})
