from enum import Enum
import functools

from django.db import models
from django.db.models import Q, F
from django.utils import timezone
from django.utils.functional import cached_property
from django.utils.dateparse import parse_datetime
from django.core import exceptions


class Phase(models.Model):
    name = models.CharField(max_length=200, unique=True)
    override = models.ForeignKey(
        'common.PhaseValue', null=True, blank=True,
        related_name='overriden_in',
    )

    @cached_property
    def current_value(self):
        return self.value_for_time(timezone.now())

    def value_for_time(self, time):
        if self.override is not None:
            return self.override

        values = PhaseValue.objects.filter(phase=self, enabled=True)
        values = values.filter(
            Q(active_since__lte=time) | Q(active_since__isnull=True)
        )
        values = values.order_by(
            F('active_since').desc(nulls_last=True),
            'name',
        )

        try:
            return values[0]
        except IndexError:
            return None

    def value_for_request(self, request):
        """Get Phase's value for the given request.

        If a user is logged in (via Django Admin), the "current time"
        (for the purposes of Phases) can be overridden by adding a GET param
        to the URL, e.g.:
            ?override_time=2020-01-01T00:00

        The parameter is ignored for anonymous and non-staff users.
        """
        override_time = request.GET.get('override_time', None)
        if request.user.is_staff and override_time:
            try:
                time = parse_datetime(override_time)
            except ValueError:
                time = None
            if time is None:
                raise exceptions.ValidationError('Bad time')
            return self.value_for_time(time)
        else:
            return self.current_value

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
