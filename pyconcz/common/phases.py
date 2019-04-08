from .models import Phase


def phases_processor(request):
    return {'phases': {
        sf.name: sf.value_for_request(request).name
        for sf in Phase.objects.all()
    }}
