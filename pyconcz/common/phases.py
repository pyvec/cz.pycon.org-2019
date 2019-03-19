from .models import Phase


def phases_processor(request):
    return {'phases': {
        sf.name: sf.current_name for sf in Phase.objects.all()
    }}
