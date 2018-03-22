from django.core.management.base import BaseCommand

from pyconcz_2018.proposals.models import Workshop as ProposalWorkshop
from pyconcz_2018.programme.models import Speaker, Workshop


class Command(BaseCommand):
    help = 'imports workshops from proposals to programme'

    def add_arguments(self, parser):
        parser.add_argument('-i', '--id', type=int, help='import particular workshop only (give db id)')

    def handle(self, *args, **options):
        qs = ProposalWorkshop.objects.all()
        proposals = qs.filter(id=options['id']) if options['id'] else qs.filter(accepted=True)

        for proposal in proposals:
            workshop, _ = Workshop.objects.get_or_create(
                title=proposal.title,
                defaults=dict(
                    abstract=proposal.abstract,
                    language=proposal.language,
                    difficulty=proposal.difficulty,
                    type=proposal.type,
                    length=proposal.length,
                    is_backup=proposal.is_backup,
                    private_note=proposal.note,
                )
            )

            speaker, _ = Speaker.objects.get_or_create(
                email=proposal.email,
                defaults=dict(
                    full_name=proposal.full_name,
                    bio=proposal.bio,
                    twitter=proposal.twitter,
                    github=proposal.github,
                    photo=proposal.photo
                )
            )

            speaker.workshops.add(workshop)
