from django.conf.urls import url

from pyconcz.intermission import views


urlpatterns = [
    url('^$', views.index, name='cycle_all'),
    url('^sponsors/(?P<level>[\w\-]+)/$', views.sponsors, name='sponsors'),
    url('^annoucements/$', views.announcements, name='annoucements'),
    url('^up-next/(?P<track>\d+)/$', views.up_next, name='up_next'),
    url('^slido/$', views.slido, name='slido'),
]
