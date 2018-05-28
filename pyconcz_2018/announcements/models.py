from django.db import models


class Announcement(models.Model):
    message = models.TextField(help_text='Markdown flavoured')
    date_created = models.DateTimeField(auto_now_add=True)
    is_public = models.BooleanField(default=False)

    class Meta:
        get_latest_by = 'date_created'
        ordering = ['-date_created']

    def __str__(self):
        return self.message[:30] + '…' if len(self.message) > 30 else self.message
