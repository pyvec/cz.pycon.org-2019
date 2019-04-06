from django.conf.urls import url
from django.views.generic import RedirectView

from .views import talks_list, workshops_list, schedule
from .views import talk_detail, preview

urlpatterns = [
    url('^$', RedirectView.as_view(pattern_name='talks_list')),
    url('^talks/$', talks_list, name='talks_list'),
    url('^workshops/$', workshops_list, name='workshops_list'),
    url('^detail/(?P<type>(talk|workshop|sprint))/(?P<talk_id>\d+)/$', talk_detail, name='talk_detail'),
    url('^schedule/$', schedule, name='programme_schedule'),
    url('^preview/$', preview, name='preview'),
]
