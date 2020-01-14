from django.conf import settings
from django.conf.urls import include, url
from django.conf.urls.static import static
from django.contrib import admin
from django.views.generic import TemplateView, RedirectView

from pyconcz.common.views import homepage

prefixed_urlpatterns = [
    url(r'^$', homepage, name='homepage'),
    url(r'^programme/', include('pyconcz.programme.urls')),
    url(r'^team/', include('pyconcz.team.urls')),
    url(r'^proposals/', include('pyconcz.proposals.urls')),
    url(r'^announcements/', include('pyconcz.announcements.urls')),
    url(r'^sponsors/', include('pyconcz.sponsors.urls')),
    url(r'^tickets/', include('pyconcz.common.urls')),
    url(r'^intermission/', include('pyconcz.intermission.urls', namespace='intermission')),

    # static pages
    url(r'^coc/$', TemplateView.as_view(template_name='pages/coc.html'), name='coc'),
    url(r'^privacy-policy/$', TemplateView.as_view(template_name='pages/privacy-policy.html'), name='privacy_policy'),
    url(r'^ostrava/$', TemplateView.as_view(template_name='pages/ostrava.html'), name='city'),
    url(r'^venue/$', TemplateView.as_view(template_name='pages/venue.html'), name='venue'),
    url(r'^board-game-night/$', TemplateView.as_view(template_name='pages/board_game_night.html'), name='board_game_night'),
    url(r'^workshop-leaders-info/$', TemplateView.as_view(template_name='pages/workshop_leaders_info.html'), name='workshop_leaders_info'),
    url(r'^pattern-lib/$', TemplateView.as_view(template_name='pages/pattern-lib.html'), name='pattern_lib'),

    # redirects to external websites
    url(r'^video/$', RedirectView.as_view(url='https://www.youtube.com/watch?v=kL2gmhs0irI')),


    # static pages
    # url(r'^transparency-report/$', TemplateView.as_view(template_name='pages/transparency.html'), name='about_transparency'),

    # old urls redirect (delete when changing 2019 to 2020)
    url(r'^about/code/?$', RedirectView.as_view(url='/2019/coc/', permanent=True)),
    url(r'^about/privacy/?$', RedirectView.as_view(url='/2019/privacy-policy/', permanent=True)),
    url(r'^about/team/?$', RedirectView.as_view(url='/2019/team/', permanent=True)),
]

urlpatterns = (
        static(settings.STATIC_URL, document_root=settings.STATIC_ROOT) +
        static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT) +
        [
            url(r'^coc/$', RedirectView.as_view(url='/2019/coc/')),
            url(r'^2019/', include(prefixed_urlpatterns)),
            url(r'^admin/', include(admin.site.urls)),
            url(r'^$', RedirectView.as_view(url='/2019/')),
        ]
)
