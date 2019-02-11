from django import template

register = template.Library()


@register.filter
def verbose_name(field):
    return "TODO verbose_name ➡ " + field
