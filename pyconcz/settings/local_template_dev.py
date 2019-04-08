from . import *

DEBUG = True
SECRET_KEY = 42

CSRF_COOKIE_SECURE = False
SESSION_COOKIE_SECURE = False

ALLOWED_HOSTS = ['localhost', '127.0.0.1', '[::1]']
INTERNAL_IPS = ('127.0.0.1',)

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.dummy.DummyCache',
    }
}

# SQLite
#
# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.sqlite3',
#         'NAME': './2019.sqlite3',
#     }
# }

# PostgreSQL
#

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'HOST': '127.0.0.1',
        'NAME': 'pycon2019',
        'USER': 'pycon2019',
        'PASSWORD': '',  # fill in please
        'PORT': 5432,
    }
}


def show_toolbar(request):
    return not request.is_ajax()


STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static')
]

SLACK_WEBHOOK = ''  # Webhook URL for slack CFP notifications

TITO_ACCOUNT_NAME = 'pyvec'
TITO_EVENT_NAME = 'pycon-cz-2019'
TITO_SECRET_KEY = 'ti.to-secret-key-here'
