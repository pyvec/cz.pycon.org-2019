from django.conf import settings
from django.contrib.contenttypes.fields import GenericForeignKey
from django.contrib.contenttypes.models import ContentType
from django.db import models


class Speaker(models.Model):
    full_name = models.CharField(max_length=200)
    bio = models.TextField()

    twitter = models.CharField(max_length=255, blank=True)
    github = models.CharField(max_length=255, blank=True)
    email = models.EmailField()

    photo = models.ImageField(upload_to='programme/pyconcz2018/')

    talks = models.ManyToManyField('Talk', blank=True, related_name='talk_speakers')
    workshops = models.ManyToManyField('Workshop', blank=True, related_name='ws_speakers')

    display_position = models.PositiveSmallIntegerField(default=0, help_text='sort order on frontend displays')
    is_public = models.BooleanField(default=True)

    class Meta:
        ordering = ('display_position', 'full_name',)

    def __str__(self):
        return self.full_name


class Talk(models.Model):
    DIFFICULTY = (
        ('beginner', 'Beginner'),
        ('advanced', 'Advanced'),
    )

    LANGUAGES = (
        ('en', 'English (preferred)'),
        ('cs', 'Czechoslovak'),
    )

    title = models.CharField(max_length=200)
    abstract = models.TextField()
    language = models.CharField(max_length=2, choices=LANGUAGES, default='en')
    difficulty = models.CharField(max_length=10, choices=DIFFICULTY, default='beginner',)
    video_id = models.CharField(max_length=100, default='', blank=True, help_text='youtube')

    private_note = models.TextField(default='', blank=True, help_text='DO NOT SHOW ON WEBSITE')
    is_backup = models.BooleanField(default=False, blank=True)
    is_keynote = models.BooleanField(default=False, blank=True)
    is_public = models.BooleanField(default=False, blank=True)

    class Meta:
        ordering = ('title',)

    def __str__(self):
        return self.title

    @property
    def speakers(self):
        return self.talk_speakers.all()

    @property
    def speakers_display(self):
        return ','.join(map(str, self.speakers))

    @property
    def video_embed_url(self):
        return 'https://www.youtube.com/embed/' + self.video_id


class Workshop(models.Model):
    DIFFICULTY = (
        ('beginner', 'Beginner'),
        ('advanced', 'Advanced'),
    )

    TYPE = (
        ('workshop', 'Workshop'),
        ('sprint', 'Sprint'),
    )

    LENGTH = (
        ('1h', '1 hour'),
        ('2h', '2 hours'),
        ('2h', '3 hours'),
        ('1d', 'Full day (most sprints go here!)'),
        ('xx', 'Something else! (Please leave a note in the abstract!)')
    )

    LANGUAGES = (
        ('en', 'English (preferred)'),
        ('cs', 'Czech/Slovak'),
    )

    type = models.CharField(
        max_length=10, choices=TYPE, default='sprint'
    )
    title = models.CharField(
        max_length=200, verbose_name='Title'
    )
    abstract = models.TextField()
    language = models.CharField(
        max_length=2, choices=LANGUAGES, default='en'
    )
    difficulty = models.CharField(
        max_length=10, choices=DIFFICULTY, default='beginner',
    )
    length = models.CharField(
        max_length=2, choices=LENGTH, blank=True,
    )

    private_note = models.TextField(default='', blank=True, help_text='DO NOT SHOW ON WEBSITE')
    is_backup = models.BooleanField(default=False, blank=True)
    is_public = models.BooleanField(default=False, blank=True)

    def __str__(self):
        return self.title

    @property
    def speakers(self):
        return self.ws_speakers.all()

    @property
    def speakers_display(self):
        return ','.join(map(str, self.speakers))


class Slot(models.Model):
    date = models.DateTimeField()

    content_type = models.ForeignKey(
        ContentType, null=True, blank=True, on_delete=models.CASCADE)
    object_id = models.PositiveIntegerField(null=True, blank=True)
    content_object = GenericForeignKey('content_type', 'object_id')

    description = models.CharField(max_length=100, blank=True, default='')
    room = models.PositiveSmallIntegerField(choices=settings.ALL_ROOMS)

    class Meta:
        ordering = ('date', 'room',)


class EndTime(models.Func):
    template = 'LAG(date) OVER (PARTITION BY room ORDER BY date DESC)'

    def __init__(self):
        super().__init__(output_field=models.DateTimeField())

    def get_group_by_cols(self):
        return []
