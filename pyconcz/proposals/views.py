from django.conf import settings
from django.core.mail import send_mail
from django.forms import modelform_factory
from django.http import Http404
from django.shortcuts import redirect
from django.template.response import TemplateResponse, get_template
from django.utils.timezone import now

from pyconcz.proposals.config import proposals


def proposal_create(request, *, key):
    try:
        config = proposals.get_config(key)
    except KeyError:
        raise Http404

    context = {'proposal_config': config}

    is_public = not request.user.is_superuser
    right_now = now()
    if is_public and config.date_start > right_now:
        return TemplateResponse(request, 'proposals/proposal_before.html', context)
    elif is_public and config.date_end < right_now:
        return TemplateResponse(request, 'proposals/proposal_after.html', context)

    ProposalForm = modelform_factory(config.model,
                                     exclude=['note', 'date', 'accepted',
                                              'is_public', 'is_backup',
                                              'is_keynote'])

    ProposalForm.base_fields['gdpr_consent'].required = True

    if request.method.lower() == 'post':
        form = ProposalForm(request.POST, request.FILES)

        if form.is_valid():
            proposal = form.save()
            send_mail(
                config.email_subject,
                get_template(config.template_email).render({"proposal": proposal}),
                settings.DEFAULT_FROM_EMAIL,
                (proposal.email, ),
            )
            return redirect(to='proposal_success', key=key)

    else:
        form = ProposalForm()

    context['form'] = form
    return TemplateResponse(request, 'proposals/proposal_form.html', context)


def proposal_success(request, *, key):
    try:
        config = proposals.get_config(key)
    except KeyError:
        raise Http404

    context = {'proposal_config_key': key, 'proposal_config': config}

    return TemplateResponse(request, 'proposals/proposal_success.html', context)


def proposal_about(request, *, key):
    try:
        config = proposals.get_config(key)
    except KeyError:
        raise Http404

    context = {'proposal_config': config}
    return TemplateResponse(request, config.template_about, context)
