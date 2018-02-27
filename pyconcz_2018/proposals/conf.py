from datetime import datetime

from django.utils.timezone import get_current_timezone

from pyconcz_2018.proposals.models import Talk, Workshop, FinancialAid

tz = get_current_timezone()


class TalksConfig:
    model = Talk
    key = 'talks'
    title = 'Talks'
    cfp_title = 'Submit your talk'
    template_about = 'proposals/talks_about.html'
    date_start = datetime(year=2018, month=1, day=17, hour=12, minute=0, tzinfo=tz)
    date_end = datetime(year=2018, month=3, day=10, hour=23, minute=59, second=59, tzinfo=tz)


class WorkshopsConfig:
    model = Workshop
    key = 'workshops'
    title = 'Workshops'
    cfp_title = 'Submit your workshop'
    template_about = 'proposals/workshops_about.html'
    date_start = datetime(year=2018, month=1, day=17, hour=12, minute=0, tzinfo=tz)
    date_end = datetime(year=2018, month=3, day=10, hour=23, minute=59, second=59, tzinfo=tz)


class FinancialAidConfig:
    model = FinancialAid
    key = 'financial-aid'
    title = 'Financial Aid'
    cfp_title = 'Financial Aid Programme'
    template_about = 'proposals/financial_aid_about.html'
    date_start = datetime(year=2018, month=1, day=17, hour=12, minute=0, tzinfo=tz)
    date_end = datetime(year=2018, month=4, day=30, hour=23, minute=59, second=59, tzinfo=tz)
