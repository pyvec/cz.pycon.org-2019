from django import template

from pyconcz.sponsors.models import Sponsor

register = template.Library()


@register.inclusion_tag('sponsors/sponsors_inline.html')
def sponsors():
    items = Sponsor.objects.all().filter(published=True)
    return {'sponsors': items}
