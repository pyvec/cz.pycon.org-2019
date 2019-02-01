from datetime import datetime

from django.utils.timezone import get_current_timezone

from pyconcz.proposals.models import Talk, Workshop, FinancialAid

tz = get_current_timezone()


class TalksConfig:
    model = Talk
    key = 'talks'
    title = 'Talk'
    cfp_title = 'Call for Papers: Talks'
    email_subject = "Thank you for your Talk proposal"
    template_about = 'proposals/talks_about.html'
    template_email = "proposals/emails/sent_talk.tpl"
    date_start = datetime(year=2019, month=1, day=20, hour=8, minute=0, tzinfo=tz)
    date_end = datetime(year=2019, month=2, day=17, hour=23, minute=59, second=59, tzinfo=tz)


class WorkshopsConfig:
    model = Workshop
    key = 'workshops'
    title = 'Workshop'
    cfp_title = 'Call for Papers: Workshops'
    email_subject = "Thank you for your Workshop proposal"
    template_about = 'proposals/workshops_about.html'
    template_email = "proposals/emails/sent_workshop.tpl"
    date_start = datetime(year=2019, month=1, day=20, hour=8, minute=0, tzinfo=tz)
    date_end = datetime(year=2019, month=2, day=17, hour=23, minute=59, second=59, tzinfo=tz)


class FinancialAidConfig:
    model = FinancialAid
    key = 'financial-aid'
    title = 'Financial Aid'
    cfp_title = 'Finan&shy;cial Aid Applica&shy;tion'
    email_subject = "We've received your Financing Aid application"
    template_about = 'proposals/financial_aid_about.html'
    template_email = "proposals/emails/sent_financial_aid.tpl"
    date_start = datetime(year=2019, month=1, day=20, hour=8, minute=0, tzinfo=tz)
    date_end = datetime(year=2019, month=2, day=17, hour=23, minute=59, second=59, tzinfo=tz)
