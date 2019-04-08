from django.conf.urls import url
from django.views.generic import RedirectView

from .views import talks_list, workshops_list, schedule
from .views import session_detail, preview

urlpatterns = [
    url('^$', RedirectView.as_view(pattern_name='talks_list')),
    url('^(?P<type>(talk|workshop|sprint))s/(?P<session_id>\\d+)/$', session_detail, name='session_detail'),
    url('^talks/$', talks_list, name='talks_list'),
    url('^workshops/$', workshops_list, name='workshops_list'),
    url('^schedule/$', schedule, name='programme_schedule'),
    url('^preview/$', preview, name='preview'),
]
