from django.conf.urls import url

from pyconcz.proposals.views import (
    proposal_success, proposal_create, proposal_about)


urlpatterns = [
    url('^(?P<key>[^/]*)/$', proposal_about, name='proposal_about'),
    url('^(?P<key>[^/]*)/form/$', proposal_create, name='proposal_form'),
    url('^(?P<key>[^/]*)/sent/$', proposal_success, name='proposal_success'),
]
