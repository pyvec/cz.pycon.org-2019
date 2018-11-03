from django.core.management.base import BaseCommand, CommandError
from django.template.loader import render_to_string

from pyconcz_2018.proposals.models import Talk, Workshop, FinancialAid

PROPOSAL_MAP = dict(
    talk=Talk.objects.filter(accepted=True),
    workshop=Workshop.objects.filter(accepted=True, type='workshop'),
    sprint=Workshop.objects.filter(accepted=True, type='sprint'),
    aid=FinancialAid.objects.filter(accepted=True)
)


class Command(BaseCommand):

    def add_arguments(self, parser):
        parser.add_argument('proposal_type', choices=PROPOSAL_MAP.keys(), help='proposal type',)

    def handle(self, *args, **options):
        qs = PROPOSAL_MAP.get(options['proposal_type'])
        for one in qs:
            tpl = 'proposals/emails/accepted_%s.tpl' % options['proposal_type']
            first_name = one.full_name.split()[0]
            self.stdout.write('TO: '+one.email+'\n\n')
            self.stdout.write(render_to_string(tpl, dict(first_name=first_name, title=one.title)))
            self.stdout.write('\n\n\n----- CUT HERE ----- \n\n\n')
