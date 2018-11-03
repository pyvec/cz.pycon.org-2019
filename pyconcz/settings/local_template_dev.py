from . import *

DEBUG = True
SECRET_KEY = 42

CSRF_COOKIE_SECURE = False
SESSION_COOKIE_SECURE = False

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': 'pyconcz',
    }
}


def show_toolbar(request):
    return not request.is_ajax()

STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static')
]

SLACK_WEBHOOK = ''  # Webhook URL for slack CFP notifications

INTERNAL_IPS = ('127.0.0.1',)
