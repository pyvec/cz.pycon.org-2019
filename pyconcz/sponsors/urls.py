from django.conf.urls import url
from django.views.generic import TemplateView

from pyconcz.sponsors.views import sponsors_list


urlpatterns = [
    url('^$', sponsors_list, name='sponsors_list'),

    url(r'^offer/$',
        TemplateView.as_view(template_name='pages/sponsors_offer.html'),
        name='sponsors_offer'),
]
