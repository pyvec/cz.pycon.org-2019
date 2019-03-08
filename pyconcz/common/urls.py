from django.conf.urls import url

from pyconcz.common.views import tickets_index


urlpatterns = [
    url('^$', tickets_index, name="tickets"),
]
