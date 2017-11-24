from django.template.response import TemplateResponse

from pyconcz_2018.programme.models import Speaker


def homepage(request):
    keynoters = Speaker.objects.filter(keynote=True, is_public=True)

    return TemplateResponse(
        request, 'pages/homepage.html', {'keynoters': keynoters})
