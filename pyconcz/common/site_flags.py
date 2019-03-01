from .models import SiteFlag


def site_flag_processor(request):
    return {'site_flags': SiteFlag.get_active_flags()}
