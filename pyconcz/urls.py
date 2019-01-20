from django.conf import settings
from django.conf.urls import include, url
from django.conf.urls.static import static
from django.contrib import admin
from django.views.generic import TemplateView, RedirectView

from pyconcz.common.views import homepage

'''
prefixed_urlpatterns = [
    url(r'^$', homepage, name='homepage'),
    #url(r'^announcements/', include('pyconcz.announcements.urls')),
    url(r'^proposals/', include('pyconcz.proposals.urls')),

    url(r'^programme/', include('pyconcz.programme.urls')),
    url(r'^sponsors/', include('pyconcz.sponsors.urls')),
    url(r'^intermission/', include('pyconcz.intermission.urls', namespace='intermission')),

    # static pages
    url(r'^proposals/$',
        TemplateView.as_view(template_name='proposals/talks_about.html'),
        name='proposals'),
    url(r'^tickets/$',
        TemplateView.as_view(template_name='pages/tickets.html'),
        name='tickets'),
    url(r'^board-game-night/$',
        TemplateView.as_view(template_name='pages/board_game_night.html'),
        name='board_game_night'),
    url(r'^about/$',
        TemplateView.as_view(template_name='pages/about.html'),
        name='about'),
    url(r'^about/code/$',
        TemplateView.as_view(template_name='pages/code.html'),
        name='about_code'),
    url(r'^about/privacy/$',
        TemplateView.as_view(template_name='pages/privacy.html'),
        name='about_privacy'),
    # url(r'^about/transparency-report/$',
    #    TemplateView.as_view(template_name='pages/transparency.html'),
    #    name='about_transparency'),
    url(r'^about/prague/$',
        TemplateView.as_view(template_name='pages/prague.html'),
        name='about_city'),
    url(r'^pattern-lib/$',
        TemplateView.as_view(template_name='pages/pattern-lib.html'),
        name='pattern_lib'),
]
'''

prefixed_urlpatterns = [
    url(r'^$', TemplateView.as_view(template_name='pages/minimal_landing.html'), name='homepage'),
    url(r'about/code/$', TemplateView.as_view(template_name='pages/code.html'), name='about_code'),
    url(r'^about/team/', include('pyconcz.team.urls')),
    url(r'^proposals/', include('pyconcz.proposals.urls')),
    
    # static pages
    url(r'^proposals/$',
        TemplateView.as_view(template_name='proposals/talks_about.html'),
        name='proposals'),
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
