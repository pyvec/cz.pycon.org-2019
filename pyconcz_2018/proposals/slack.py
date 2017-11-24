import json
import urllib.request

from django.conf import settings
from django.core.urlresolvers import reverse
from django.utils.timezone import now


def notify_slack(sender, instance, created, *args, **kwargs):
    if not created or settings.DEBUG or not settings.SLACK_WEBHOOK:
        return

    title = instance.title
    author = instance.full_name
    t = sender.__name__.lower()
    fallback = ("New {type} proposal submitted by {author} ({title})"
                .format(author=author, title=title, type=t))

    title_link = (
        "https://cz.pycon.org/" +
        reverse('admin:proposals_{t}_change'.format(t=t), args=[instance.id]))

    payload = {
        "username": "PyCon Czechia Bot",
        "icon_emoji": ":loudspeaker:",
        "attachments": [
            {
                "fallback": fallback,
                "color": "#36a64f",
                "pretext": "New {type} proposal submitted".format(type=t),
                "author_name": author,
                "title": title,
                "title_link": title_link,
                "footer": "PyCon CZ 2016",
                "ts": now().timestamp()
            }
        ]
    }

    try:
        details = json.dumps(payload).encode('UTF-8')
        url = urllib.request.Request(
            settings.SLACK_WEBHOOK, details,
            headers={'content-type': 'application/json'})
        urllib.request.urlopen(url)
    except:
        "Yes, silence it! We don't want to abort user's request."
