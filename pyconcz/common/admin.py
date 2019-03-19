from django.contrib import admin
from django.template import loader
from django import forms

from .models import Phase, PhaseValue


class ValueInline(admin.TabularInline):
    model = PhaseValue
    fields = ['name', 'enabled', 'active_since']
    list_display = ['name', 'enabled', 'active_since']
    list_editable = ['name', 'enabled', 'active_since']
    extra = 1


class PhaseAdminForm(forms.ModelForm):
    """Form that filters the 'override' field to only one flag's values"""
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        instance = kwargs.get('instance')
        if instance:
            # Get values only for the current Phase
            queryset = PhaseValue.objects.filter(phase=instance)
        else:
            # No Phase yet (adding a new one): don't show any values
            queryset = PhaseValue.objects.none()
        self.fields['override'].queryset = queryset

    class Meta:
        model = Phase
        fields = ['override', 'name']

    override = forms.ModelChoiceField(
        queryset=PhaseValue.objects.all(),  # overriden in __init__
        required=False,
    )


class PhaseAdmin(admin.ModelAdmin):
    fields = ['name', 'override']

    form = PhaseAdminForm

    def get_changelist_form(self, request, **kwargs):
        return PhaseAdminForm

    def values(self):
        template = loader.get_template('admin/common/phase_values.html')
        return template.render(context={
            'values': sorted(self.values.filter()),
            'current_value': self.current_value,
        })

    list_display = ['name', 'override', 'current_value', values]

    list_editable = ['override']
    inlines = [ValueInline]

admin.site.register(Phase, PhaseAdmin)
