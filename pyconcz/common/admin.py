from django.contrib import admin

from .models import SiteFlag


class SiteFlagAdmin(admin.ModelAdmin):
    fields = ['name', 'value_type', 'switch_time']
    list_display = ['name', 'value_type', 'switch_time', 'current_value']


admin.site.register(SiteFlag, SiteFlagAdmin)
