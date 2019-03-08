from .base import *

SECRET_KEY = ''  # fill in, please

ALLOWED_HOSTS = ['cz.pycon.org',  # main site
                 'czpyconorg-1994.rostiapp.cz',  # "beta site"
                 ]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'pycon2019',
        'USER': 'pycon2019',
        'PASSWORD': '',  # fill in please
        'HOST': '127.0.0.1',
        'ATOMIC_REQUESTS': True,
        'CONN_MAX_AGE': 1800,
        },
}

SLACK_WEBHOOK = ''  # Webhook URL for slack CFP notifications

TITO_SECRET_KEY = '' # Secret key to access TITO API.
TITO_EVENT_NAME = "pycon-cz-2019" # Name of the event TITO service
TITO_ACCOUNT_NAME = "pyvec" # Name of the TITO account