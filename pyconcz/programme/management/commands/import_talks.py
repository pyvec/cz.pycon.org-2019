from django.core.management.base import BaseCommand

from pyconcz.proposals.models import Talk as ProposalTalk
from pyconcz.programme.models import Speaker, Talk


class Command(BaseCommand):
    help = 'imports talks from proposals to programme'

    def add_arguments(self, parser):
        parser.add_argument('-i', '--id', type=int, help='import particular talk only (give particular id)')

    def handle(self, *args, **options):
        qs = ProposalTalk.objects.all()
        proposals = qs.filter(id=options['id']) if options['id'] else qs.filter(accepted=True)

        for proposal in proposals:
            talk, _ = Talk.objects.get_or_create(
                title=proposal.title,
                defaults=dict(
                    abstract=proposal.abstract,
                    language=proposal.language,
                    difficulty=proposal.difficulty,
                    is_keynote=proposal.is_keynote,
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

            speaker.talks.add(talk)
