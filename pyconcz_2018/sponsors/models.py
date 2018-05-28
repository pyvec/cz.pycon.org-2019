# coding=utf-8

from django.db import models

from extended_choices import Choices


class Sponsor(models.Model):
    LEVELS = Choices(
        ('platinum', 1, 'Platinum'),
        ('gold', 2, 'Gold'),
        ('silver', 3, 'Silver'),
        ('bronze', 4, 'Bronze'),
        ('diversity', 5, 'Diversity'),
        ('media', 6, 'Media'),
        ('partners', 7, 'Partners'),
        ('coffee', 8, 'Coffee sponsor'),
        ('connectivity', 9, 'Con­nectiv­ity sponsor'),
        ('tea', 10, 'Tea sponsor'),
    )

    level = models.PositiveSmallIntegerField(choices=LEVELS, default=LEVELS.silver)

    name = models.CharField(max_length=200)
    logo = models.FileField(upload_to='sponsors/pyconcz_2018/')

    description = models.TextField()
    link_url = models.URLField()
    twitter = models.URLField(null=True, blank=True, help_text='full URL')
    facebook = models.URLField(null=True, blank=True, help_text='full URL')

    published = models.BooleanField(default=False)

    class Meta:
        ordering = ['level', 'name']

    def __str__(self):
        return self.name
