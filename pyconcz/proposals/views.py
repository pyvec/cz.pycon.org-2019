from django.forms import modelform_factory
from django.http import Http404
from django.shortcuts import redirect
from django.template import RequestContext
from django.template.response import TemplateResponse
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

    ProposalForm = modelform_factory(config.model, exclude=['note', 'date', 'accepted'])

    if request.method.lower() == 'post':
        form = ProposalForm(request.POST, request.FILES)

        if form.is_valid():
            form.save()
            return redirect(to='proposal_success', key=key)

    else:
        form = ProposalForm()

    context['form'] = form
    return TemplateResponse(request, 'proposals/proposal_form.html', context)


def proposal_success(request, *, key):
    context = {'proposal_config_key': key}
    return TemplateResponse(request, 'proposals/proposal_success.html', context)


def proposal_about(request, *, key):
    try:
        config = proposals.get_config(key)
    except KeyError:
        raise Http404

    context = {'proposal_config': config}
    return TemplateResponse(request, config.template_about, context)
