from django.conf import settings
from django import template

register = template.Library()


@register.filter
def day_type(value):
    date = value.date()

    if date in settings.WORKSHOPS_DATES:
        return 'workshops'
    elif date in settings.TALKS_DATES:
        return 'talks'
