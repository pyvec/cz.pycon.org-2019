from enum import Enum
import functools

from django.db import models
from django.db.models import Q, F
from django.utils import timezone
from django.utils.functional import cached_property


class Phase(models.Model):
    name = models.CharField(max_length=200, unique=True)
    override = models.ForeignKey(
        'common.PhaseValue', null=True, blank=True,
        related_name='overriden_in',
    )

    @cached_property
    def current_value(self):
        if self.override is not None:
            return self.override

        now = timezone.now()
        values = PhaseValue.objects.filter(phase=self, enabled=True)
        values = values.filter(
            Q(active_since__lte=now) | Q(active_since__isnull=True)
        )
        values = values.order_by(
            F('active_since').desc(nulls_last=True),
            'name',
        )
        try:
            return values[0]
        except IndexError:
            return None

    @property
    def current_name(self):
        if self.current_value is None:
            return None
        else:
            return self.current_value.name

    def __str__(self):
        return self.name

    def __getitem__(self, name):
        return self.values.filter(name=name).one()

    class Meta:
        ordering = ('name', )


@functools.total_ordering
class PhaseValue(models.Model):
    phase = models.ForeignKey(Phase, related_name='values')
    name = models.CharField(max_length=200)
    active_since = models.DateTimeField(null=True, blank=True)
    enabled = models.BooleanField(default=True)

    class Meta:
        unique_together = ('phase', 'name')
        ordering = (
            'phase__name',
            'enabled',
            'active_since',
            'name',
        )

    def __str__(self):
        return self.name

    @property
    def _sort_key(self):
        return (
            self.phase.name,
            self.active_since is not None,
            self.active_since,
        )

    def __le__(self, other):
        return self._sort_key < other._sort_key

    def __bool__(self):
        return self == self.phase.current_value
