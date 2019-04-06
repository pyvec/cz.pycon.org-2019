from django.conf.urls import url
from django.views.generic import RedirectView

from .views import talk_list, workshop_list, schedule
from .views import talk_detail, preview

urlpatterns = [
    url('^$', RedirectView.as_view(pattern_name='talk_list')),
    url('^talks/$', talk_list, name="talk_list"),
    url('^workshops/$', workshop_list, name="workshop_list"),
    url('^detail/(?P<type>(talk|workshop|sprint))/(?P<talk_id>\d+)/$', talk_detail, name='talk_detail'),
    url('^schedule/$', schedule, name="programme_schedule"),
    url('^preview/$', preview, name="preview"),
]
