from django.conf.urls import url

from pyconcz.common.views import tickets_index, tickets_ajax_content


urlpatterns = [
    url('^$', tickets_index, name='tickets'),
    url('^ajax-content$', tickets_ajax_content, name='tickets_ajax_content'),
]
