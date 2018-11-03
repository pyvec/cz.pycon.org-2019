from django.template.response import TemplateResponse

from pyconcz_2018.sponsors.models import Sponsor


def sponsors_list(request):
    items = Sponsor.objects.all().filter(published=True)
    return TemplateResponse(request, 'sponsors/sponsors_list.html',
                            {'sponsors_list': items})
