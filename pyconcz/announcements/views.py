from django.shortcuts import render
from django.template.response import TemplateResponse

from pyconcz_2018.announcements.models import Announcement


def announcement_list(request):
    items = Announcement.objects.all()
    return TemplateResponse(
        request, 'announcements/archive.html', {'items': items}
    )
