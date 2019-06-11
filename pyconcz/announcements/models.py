from django.db import models
from django.core.validators import MaxValueValidator, MinValueValidator


class Announcement(models.Model):
    message = models.TextField(help_text='Markdown flavoured')
    position = models.PositiveSmallIntegerField(default=0)
    is_public = models.BooleanField(default=False)
    font_size = models.PositiveSmallIntegerField(
        default=1,
        validators=[
            MinValueValidator(1),
            MaxValueValidator(4),
        ],
        help_text='1 (largest) to 4 (smallest)'
    )

    class Meta:
        ordering = ['position']

    def __str__(self):
        return self.message[:30] + '…' if len(self.message) > 30 else self.message
