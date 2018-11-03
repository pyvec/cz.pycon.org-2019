from django import template

from pyconcz_2018.announcements.models import Announcement

register = template.Library()


@register.inclusion_tag('announcements/latest.html')
def latest_announcement():
    try:
        item = Announcement.objects.all().latest()
    except Announcement.DoesNotExist:
        item = None

    return {'item': item}
