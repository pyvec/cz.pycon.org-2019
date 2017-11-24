import os

# Pokud se settings nachaz   v /srv/app/moje_aplikace,
# bude obsah pro DJANGO_SETTINGS_MODULE: moje_aplikace.settings
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "pyconcz_2018.settings")

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
