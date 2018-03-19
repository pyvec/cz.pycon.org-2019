from import_export import resources
from import_export.admin import ImportExportActionModelAdmin
from import_export import fields

from django.contrib import admin
from .models import Speaker, Talk, Slot, Workshop


def mk_public(modeladmin, request, queryset):
    queryset.update(is_public=True)
mk_public.short_description = 'Make public'


class SlotAdmin(admin.ModelAdmin):
    list_display = ['get_description', 'date', 'room']
    list_filter = ['room', 'date', ]
    list_editable = ['room', 'date']
    date_hierarchy = 'date'

    def get_queryset(self, request):
        return super().get_queryset(request).prefetch_related('content_object')

    def get_description(self, obj):
        return obj.content_object or obj.description


class SpeakerResource(resources.ModelResource):

    class Meta:
        model = Speaker
        fields = export_order = (
            'full_name',
            'email', 'github', 'twitter',
        )


class SpeakerAdmin(ImportExportActionModelAdmin):
    list_display = ['full_name', 'get_talks', 'get_workshops',
                    'is_public', 'display_position', ]
    list_filter = ['is_public']
    search_fields = ['full_name', 'email', 'github', 'twitter', ]
    resource_class = SpeakerResource
    actions = [mk_public, ]

    def get_talks(self, obj):
        return ', '.join([t.title for t in obj.talks.all()])
    get_talks.short_description = 'talks'

    def get_workshops(self, obj):
        return ', '.join([w.title for w in obj.workshops.all()])
    get_workshops.short_description = 'workshops'


class TalkResource(resources.ModelResource):
    speakers = fields.Field(attribute='speakers_display', column_name='speakers')

    class Meta:
        model = Talk
        fields = export_order = (
            'title', 'speakers',
            'language', 'difficulty', 'is_keynote', 'is_public', 'is_backup', 'private_note',
        )


class TalkAdmin(ImportExportActionModelAdmin):
    list_display = ['title', 'speakers', 'language', 'is_keynote', 'is_public', 'is_backup', ]
    list_filter = ['is_keynote', 'is_public', 'is_backup', ]
    search_fields = ['title', ]
    resource_class = TalkResource
    actions = [mk_public, ]

    def speakers(self, obj):
        return obj.speakers_display
    speakers.short_description = 'speakers'


class WorkshopAdmin(TalkAdmin):
    list_display = ['title', 'speakers', 'language', 'difficulty', 'type', 'is_public', 'is_backup', ]
    list_filter = ['is_public', 'is_backup', ]
    list_filter = ['type', ]
    actions = [mk_public, ]


admin.site.register(Speaker, SpeakerAdmin)
admin.site.register(Talk, TalkAdmin)
admin.site.register(Workshop, WorkshopAdmin)
admin.site.register(Slot, SlotAdmin)
