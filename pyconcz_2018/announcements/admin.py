from django.contrib import admin

from pyconcz_2018.announcements.models import Announcement


class AnnouncementAdmin(admin.ModelAdmin):
    list_display = ('message', 'date_created', 'is_public',)
    list_filter = ('date_created', 'is_public',)


admin.site.register(Announcement, AnnouncementAdmin)
