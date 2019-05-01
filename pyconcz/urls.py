from django.conf import settings
from django.conf.urls import include, url
from django.conf.urls.static import static
from django.contrib import admin
from django.views.generic import TemplateView, RedirectView

from pyconcz.common.views import homepage

'''
prefixed_urlpatterns = [
    url(r'^intermission/', include('pyconcz.intermission.urls', namespace='intermission')),
    # static pages
    url(r'^about/transparency-report/$',
        TemplateView.as_view(template_name='pages/transparency.html'),
        name='about_transparency'),
]
'''

prefixed_urlpatterns = [
    url(r'^$', homepage, name='homepage'),
    url(r'^programme/', include('pyconcz.programme.urls')),
    url(r'^about/team/', include('pyconcz.team.urls')),
    url(r'^proposals/', include('pyconcz.proposals.urls')),
    url(r'^announcements/', include('pyconcz.announcements.urls')),
    url(r'^sponsors/', include('pyconcz.sponsors.urls')),
    url(r'^tickets/', include('pyconcz.common.urls')),

    # static pages
    url(r'about/code/$',
        TemplateView.as_view(template_name='pages/code.html'),
        name='about_code'),
    url(r'^about/privacy/$',
        TemplateView.as_view(template_name='pages/privacy.html'),
        name='about_privacy'),
    url(r'^proposals/$',
        TemplateView.as_view(template_name='proposals/talks_about.html'),
        name='proposals'),
    url(r'^pattern-lib/$',
        TemplateView.as_view(template_name='pages/pattern-lib.html'),
        name='pattern_lib'),
    url(r'^ostrava/$',
        TemplateView.as_view(template_name='pages/ostrava.html'),
        name='city'),
    url(r'^venue/$',
        TemplateView.as_view(template_name='pages/venue.html'),
        name='venue'),
    url(r'^board-game-night/$',
        TemplateView.as_view(template_name='pages/board_game_night.html'),
        name='board_game_night'),
]

urlpatterns = (
    static(settings.STATIC_URL, document_root=settings.STATIC_ROOT) +
    static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT) +
    [
        url(r'^2019/', include(prefixed_urlpatterns)),
        url(r'^admin/', include(admin.site.urls)),
        url(r'^$', RedirectView.as_view(url='/2019/')),
    ]
)
