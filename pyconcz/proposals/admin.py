from import_export import resources
from import_export.admin import ImportExportActionModelAdmin

from django import forms
from django.conf.urls import url
from django.contrib import admin
from django.contrib import messages
from django.contrib.contenttypes.models import ContentType
from django.core.urlresolvers import reverse
from django.db.models import Prefetch, Avg, Count
from django.shortcuts import redirect
from django.template.response import TemplateResponse
from django.utils.html import format_html

from pyconcz.proposals.models import Ranking, Score, StdDev, FinancialAid, Talk, Workshop


class ScoreForm(forms.ModelForm):
    class Meta:
        model = Score
        fields = ('value', 'note')


class EntryAdmin(ImportExportActionModelAdmin):
    abstract = True

    list_display = [
        'date_short', 'full_name', 'title',
        'average', 'stddev', 'scount', 'score',
        'common_note', 'accepted', 'score_link',
    ]
    list_display_links = ['full_name']
    list_editable = ['accepted']
    list_filter = ['accepted']
    search_fields = ['full_name', 'email', 'title', 'github', 'twitter', ]

    change_list_template = 'admin/proposals/change_list.html'
    change_form_template = 'admin/proposals/change_form.html'

    def score(self, obj):
        try:
            return obj.get_ranking().scores.all()[0]
        except IndexError:
            return None

    score.short_description = 'Your score'

    def score_link(self, obj):
        info = self.model._meta.app_label, self.model._meta.model_name
        url = reverse('admin:%s_%s_add_score' % info, kwargs={'object_id': obj.id})
        return format_html('<a href="{url}">Score</a>', url=url)

    score_link.short_description = ''

    def average(self, obj):
        return obj.average and '{:.2f}'.format(obj.average) or None

    average.admin_order_field = 'average'

    def stddev(self, obj):
        return obj.stddev and '{:.2f}'.format(obj.stddev) or None

    stddev.admin_order_field = 'stddev'

    def scount(self, obj):
        return obj.scount or 0

    scount.admin_order_field = 'scount'

    def common_note(self, obj):
        if obj.note:
            return format_html('<span title="{}">{}&hellip;</span>',
                               obj.note, obj.note[:10])

    common_note.admin_order_field = 'common_note'

    def date_short(self, obj):
        return obj.date.strftime('%d.%m. %H:%M')

    date_short.admin_order_field = 'date_short'
    date_short.short_description = 'date'
    date_short.admin_order_field = 'date'

    def get_queryset(self, request):
        scores = Prefetch(
            'rankings__scores',
            queryset=Score.objects.filter(user=request.user)
        )
        return (
            super().get_queryset(request)
                .prefetch_related(scores)
                .annotate(
                average=Avg('rankings__scores__value'),
                stddev=StdDev('rankings__scores__value'),
                scount=Count('rankings__scores__value'),
            )
        )

    def get_readonly_fields(self, request, obj=None):
        if obj is None or request.user.is_superuser:
            return []

        return [
            field.name for field in self.model._meta.get_fields()
            if field.name not in ['id', 'rankings', 'note']
        ]

    def get_urls(self):
        info = self.model._meta.app_label, self.model._meta.model_name

        urls = [
            url(
                r'^generate/$',
                self.admin_site.admin_view(self.generate_scoring),
                name='%s_%s_generate' % info
            ),
            url(
                r'^(?P<object_id>\d+)/add_score/$',
                self.admin_site.admin_view(self.add_score),
                name='%s_%s_add_score' % info
            )
        ]

        return urls + super().get_urls()

    def generate_scoring(self, request):
        """
        Generate empty Rankings linked to custom Entries
        """

        ct = ContentType.objects.get_for_model(self.model)
        existing_ids = (
            Ranking.objects
                .filter(content_type=ct)
                .values_list('object_id', flat=True)
        )

        proposals = (
            Ranking(content_type=ct, object_id=oid) for oid in
            self.model.objects
                .exclude(id__in=existing_ids)
                .values_list('id', flat=True)
        )

        objs = Ranking.objects.bulk_create(proposals)

        obj_count = len(objs)
        if obj_count:
            msg = '{} new proposals available for scoring'
            messages.success(request, msg.format(obj_count))

        return self.redirect_to_next_unranked(request)

    def add_score(self, request, object_id):
        obj = self.model.objects.get(id=object_id)
        score_instance = (
            obj.get_ranking().scores
                .filter(user=request.user)
                .first()
        )

        if request.method.lower() == 'post':
            score_form = ScoreForm(request.POST, instance=score_instance)
            score_form.instance.user = request.user
            score_form.instance.ranking = obj.get_ranking()

            if score_form.is_valid():
                score_form.save()
                return self.redirect_to_next_unranked(request)

        else:
            score_form = ScoreForm(instance=score_instance)

        ctx = dict(
            self.admin_site.each_context(request),
            obj=obj,
            opts=self.model._meta,
            has_change_permission=self.has_change_permission(request, obj),
            form=self.get_form(request, None)(instance=obj),
            score_form=score_form
        )

        return TemplateResponse(request, 'admin/proposals/add_score.html', ctx)

    def redirect_to_next_unranked(self, request):
        ct = ContentType.objects.get_for_model(self.model)
        next_obj_id = (
            Ranking.objects
                .filter(content_type=ct)
                .exclude(scores__user=request.user)
                .order_by('?')
                .values_list('object_id', flat=True)
                .first()
        )

        info = self.model._meta.app_label, self.model._meta.model_name

        if next_obj_id:
            return redirect(
                'admin:%s_%s_add_score' % info, object_id=next_obj_id
            )
        else:
            messages.success(request, 'All your work here is done!')
            return redirect('admin:%s_%s_changelist' % info)


class TalkResource(resources.ModelResource):
    class Meta:
        model = Talk
        fields = export_order = (
            'full_name', 'title',
            'email', 'github', 'twitter',
            'language', 'difficulty',
            'needs_finaid', 'is_keynote', 'is_backup', 'accepted',
        )


class WorkshopResource(resources.ModelResource):
    class Meta:
        model = Workshop
        fields = export_order = (
            'full_name', 'title',
            'email', 'github', 'twitter',
            'language', 'difficulty',
            'needs_finaid', 'is_backup', 'accepted',
        )


class FinancialAidResource(resources.ModelResource):
    class Meta:
        model = FinancialAid
        fields = export_order = (
            'full_name', 'email', 'amount', 'accepted',
        )


class TalkAdmin(EntryAdmin):
    list_display = [
        'date_short', 'full_name', 'title',
        'average', 'stddev', 'scount', 'score',
        'is_backup', 'accepted', 'score_link',
    ]
    list_editable = ['accepted', 'is_backup']
    list_filter = ['accepted', 'needs_finaid', 'is_keynote', 'is_backup']
    resource_class = TalkResource


class WorkshopAdmin(EntryAdmin):
    list_display = [
        'date_short', 'full_name', 'title',
        'average', 'stddev', 'scount', 'score',
        'is_backup', 'accepted', 'score_link',
    ]
    list_editable = ['accepted', 'is_backup']
    list_filter = ['accepted', 'needs_finaid', 'is_backup']
    resource_class = WorkshopResource


class FinancialAidAdmin(EntryAdmin):
    resource_class = FinancialAidResource


admin.site.register(Talk, TalkAdmin)
admin.site.register(Workshop, WorkshopAdmin)
admin.site.register(FinancialAid, FinancialAidAdmin)
