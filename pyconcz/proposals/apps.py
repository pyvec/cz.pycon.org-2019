from django.apps import AppConfig


class ProposalsConfig(AppConfig):
    name = 'pyconcz.proposals'
    verbose_name = 'Conference Proposals'

    def ready(self):
        # Register proposal forms
        from pyconcz.proposals.config import proposals
        from pyconcz.proposals.conf import (
            TalksConfig, WorkshopsConfig, FinancialAidConfig)
        proposals.register(TalksConfig)
        proposals.register(WorkshopsConfig)
        proposals.register(FinancialAidConfig)

        # Register signals
        from django.db.models.signals import post_save
        from pyconcz.proposals.models import Talk, Workshop, FinancialAid
        from pyconcz.proposals.slack import notify_slack
        post_save.connect(notify_slack, sender=Talk)
        post_save.connect(notify_slack, sender=Workshop)
        post_save.connect(notify_slack, sender=FinancialAid)
