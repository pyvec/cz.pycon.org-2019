from .base import *

SECRET_KEY = ''  # fill in, please

ALLOWED_HOSTS = ['cz.pycon.org',
                 'czpyconorg-1994.rostiapp.cz',  # to be removed
                 ]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': '',
        'USER': '',
        'PASSWORD': '',
        'HOST': '',
        'ATOMIC_REQUESTS': True,
        'CONN_MAX_AGE': 1800,
        },
}

SLACK_WEBHOOK = ''  # Webhook URL for slack CFP notifications
