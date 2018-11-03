from django.db import models


class Announcement(models.Model):
    message = models.TextField(help_text='Markdown flavoured')
    position = models.PositiveSmallIntegerField(default=0)
    is_public = models.BooleanField(default=False)

    class Meta:
        ordering = ['position']

    def __str__(self):
        return self.message[:30] + '…' if len(self.message) > 30 else self.message
