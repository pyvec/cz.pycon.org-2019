from django.conf import settings
from django.contrib.contenttypes.fields import (
    GenericForeignKey, GenericRelation)
from django.contrib.contenttypes.models import ContentType
from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models
from django.db.models import Aggregate
from django.utils.timezone import now


class Ranking(models.Model):
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)
    object_id = models.PositiveIntegerField()
    content_object = GenericForeignKey('content_type', 'object_id')

    class Meta:
        unique_together = ('content_type', 'object_id')

    def get_user_score(self, user):
        return self.scores.all().filter(user=user).first()


class Score(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL)
    ranking = models.ForeignKey(Ranking, related_name='scores')

    value = models.PositiveSmallIntegerField(
        help_text="4 = Must have!, 3 = Interesting talk, "
                  "2 = Meh, 1 = Definitely not!",
        validators=[
            MinValueValidator(1),
            MaxValueValidator(4)
        ]
    )
    note = models.TextField(
        default='', blank=True,
        help_text="Only you can see this"
    )

    class Meta:
        permissions = (
            ("can_add_score", "Can add score"),
        )

    def __str__(self):
        return ' '.join([
            str(self.value),
            '({})'.format(self.note) if self.note else '']
        )


class EntryBase(models.Model):
    # Private notes (for reviewers only)
    note = models.TextField()
    date = models.DateTimeField(default=now)
    rankings = GenericRelation(Ranking)
    accepted = models.BooleanField(default=False, blank=True)

    class Meta:
        abstract = True

    def get_ranking(self):
        return self.rankings.all()[0]


class Talk(EntryBase):
    DIFFICULTY = (
        ('beginner', 'Beginner'),
        ('advanced', 'Advanced'),
    )

    LANGUAGES = (
        ('en', 'English (preferred)'),
        ('cs', 'Czech/Slovak'),
    )

    # Public speaker info
    full_name = models.CharField(
        max_length=200, verbose_name="Your name",
    )
    email = models.EmailField(
        help_text="We'll keep it secret, for internal use only."
    )
    bio = models.TextField(
        help_text="Tell us a bit about yourself! Who you are, where you"
                  " are from, what your experience with Python is. Be wild,"
                  " be creative!"
    )
    twitter = models.CharField(
        max_length=255, blank=True,
        verbose_name="Twitter handle", help_text="Optional")
    github = models.CharField(
        max_length=255, blank=True,
        verbose_name="GitHub username", help_text="Optional")
    photo = models.ImageField(
        upload_to='proposals/pyconcz2018/talks/', verbose_name="Your picture",
        help_text="Photo of yourself which we can publish on our website"
    )

    # Public talk info
    title = models.CharField(
        max_length=200, verbose_name='Talk title',
        help_text="This will be published everywhere. Make up some"
                  " catchy title which will attract the audience!"
    )
    abstract = models.TextField(
        help_text="Full description of your talk. How would you describe your"
                  " talk to the audience?"
    )
    language = models.CharField(
        max_length=2, choices=LANGUAGES, default='en'
    )
    difficulty = models.CharField(
        max_length=10, choices=DIFFICULTY, default='beginner',
        help_text="Does you talk require a high level of Python knowledge"
                  " or is it suitable for everyone?"
    )

    def __str__(self):
        return '{s.full_name} - {s.title}'.format(s=self)


class Workshop(EntryBase):
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

    # Public speaker info
    full_name = models.CharField(
        max_length=200, verbose_name="Your name",
    )
    email = models.EmailField(
        help_text="We'll keep it secret, for internal use only."
    )
    bio = models.TextField(
        help_text="Tell us a bit about yourself! Who you are, where you"
                  " are from, what your experience with Python is. Be wild,"
                  " be creative!"
    )
    twitter = models.CharField(
        max_length=255, blank=True,
        verbose_name="Twitter handle", help_text="Optional")
    github = models.CharField(
        max_length=255, blank=True,
        verbose_name="GitHub username", help_text="Optional")
    photo = models.ImageField(
        upload_to='proposals/pyconcz2018/talks/', verbose_name="Your picture",
        help_text="Photo of yourself which we can publish on our website"
    )

    # Public talk info
    type = models.CharField(
        max_length=10, choices=TYPE, default='sprint',
        help_text="At a workshop, you should present hands-on excercises for"
                  " participants to learn from. You'll get a room and a slot"
                  " in the agenda, and participants will need to register.\n"
                  " At a sprint, participants help an open-source project --"
                  " usually by cloning the repo and trying to fix"
                  " beginner-level issues, while you'll provide one-to-one"
                  " mentorship. If several experienced developers"
                  " are around, sprints are also a good place for serious"
                  " design discussions. Sprinters only need a table to sit"
                  " around, reliable wifi, and dedication to do great things!"
    )
    title = models.CharField(
        max_length=200, verbose_name='Workshop/sprint title',
        help_text="Public title. What topic/project is it all about?"
    )
    abstract = models.TextField(
        help_text="Full description of your workshop or sprint. Please also"
                  " describe requirements: libraries and Python version to be"
                  " installed, required experience with topics/libraries, etc."
    )
    language = models.CharField(
        max_length=2, choices=LANGUAGES, default='en'
    )
    difficulty = models.CharField(
        max_length=10, choices=DIFFICULTY, default='beginner',
        help_text="Does you workshop require a high level of specialized"
                  " knowledge (of Python, a library, etc.),"
                  " or is it suitable for everyone?"
    )
    length = models.CharField(
        max_length=2, choices=LENGTH, blank=True,
        help_text="How much time does your workshop take? Sprints usually take"
                  " the whole day, but workshops are organized in smaller"
                  " blocks. You can also have a full-day workshop with lunch"
                  " break, but keep in mind that the length could discourage"
                  " attendees!"
    )

    def __str__(self):
        return '[{s.type}] {s.title}'.format(s=self)


class FinancialAid(EntryBase):
    # Public speaker info
    full_name = models.CharField(
        max_length=200, verbose_name="Your name",
    )
    email = models.EmailField(
        help_text="We'll keep it secret, for internal use only."
    )
    bio = models.TextField(
        help_text="Tell us a bit about yourself! Who you are, where you are"
                  " from, and what your experience with Python is. Also"
                  " include how you are involved in the Python community and how"
                  " you contribute or plan to contribute to it."
    )
    amount = models.CharField(
        max_length=255,
        help_text="How much money would you like to receive"
                  " (please specify currency)."
    )

    purpose = models.TextField(
        help_text="How would you like to use the granted money?"
    )

    def __str__(self):
        return self.full_name

    # required for generic admin
    @property
    def title(self):
        return self.full_name


class StdDev(Aggregate):
    function = 'stddev_samp'

    def __init__(self, expression, **extra):
        super().__init__(
            expression,
            output_field=models.FloatField(),
            **extra
        )
