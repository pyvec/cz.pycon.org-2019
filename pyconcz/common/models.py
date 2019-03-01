from enum import Enum

from django.db import models
from django.utils import timezone


class SiteFlag(models.Model):
    name = models.CharField(max_length=200, unique=True)
    value_type = models.CharField(
        max_length=200,
        choices=[
            # Human-readable titles are the same as the value
            (v, v) for v in ("on", "off", "on_at", "off_at")
        ],
    )
    switch_time = models.DateTimeField(null=True, blank=True)

    def clean(self):
        if self.value_type in ("on_at", "off_at"):
            if not self.switch_time:
                self.switch_time = timezone.now()

    @property
    def current_value(self):
        now = timezone.now()
        if self.value_type == "on":
            return True

        if self.switch_time:
            switched = self.switch_time >= now
        else:
            switched = False

        if self.value_type == "on_at":
            return switched
        if self.value_type == "off_at":
            return not switched

    def __str__(self):
        return self.name

    class Meta:
        ordering = ('name', )

    @classmethod
    def get_active_flags(cls):
        now = timezone.now()
        return [obj.name for obj in (
            *cls.objects.filter(value_type="on"),
            *cls.objects.filter(value_type="on_at", switch_time__gte=now),
            *cls.objects.filter(value_type="off_at", switch_time__lt=now),
        )]
