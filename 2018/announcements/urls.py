from django.conf.urls import url

from pyconcz_2018.announcements.views import announcement_list

urlpatterns = [
    url('^$', announcement_list, name='announcements_list'),
]
