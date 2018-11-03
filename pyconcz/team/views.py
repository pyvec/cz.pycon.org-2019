from django.template import RequestContext
from django.template.response import TemplateResponse

from pyconcz_2018.team.models import Organizer


def team_list(request):
    organizers = Organizer.objects.all().filter(published=True).order_by('?')

    return TemplateResponse(
        request,
        template='team/organizers_list.html',
        context={
            'organizers': organizers
        }
    )
