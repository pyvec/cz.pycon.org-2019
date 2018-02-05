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
        help_text='4 = Must have!, 3 = Interesting talk, '
                  '2 = Meh, 1 = Definitely not!',
        validators=[
            MinValueValidator(1),
            MaxValueValidator(4)
        ]
    )
    note = models.TextField(
        default='', blank=True,
        help_text='Only you can see this'
    )

    class Meta:
        permissions = (
            ('can_add_score', 'Can add score'),
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
        ('beginner', 'Beginner  (suitable for everyone)'),
        ('advanced', 'Advanced  (requires a high level of Python knowledge)'),
    )

    LANGUAGES = (
        ('en', 'English (preferred)'),
        ('cs', 'Czech or Slovak'),
    )

    # Public speaker info
    full_name = models.CharField(
        max_length=200, verbose_name='What’s your name?',
        help_text='This will be published in the schedule,'
                  ' so use a name that you’re comfortable with, or a nickname.'
    )
    email = models.EmailField(
        verbose_name='Your email address',
        help_text='We’ll keep it secret, for internal use only.'
    )
    bio = models.TextField(
        verbose_name='Why are you the right person to talk about the topic you chose?',
        help_text='Tell your audience in first person about anything relevant about you,'
                  ' whether it’s your background, education, experience,'
                  ' current or former employer, hobbies or opensource software you maintain.'
                  '\nTry keeping it between between 50 and 90 words.'
                  '\nYou can of course include anything fun or quirky about yourself.'
    )
    referral_link = models.URLField(
        default='', blank=True,
        verbose_name='Got a video?',
        help_text='If you already have a recording of you giving a talk,'
                  ' you can paste the link here.'
    )

    twitter = models.CharField(
        max_length=255, blank=True,
        verbose_name='Twitter handle', help_text='Optional. Write it without the @.'
    )
    github = models.CharField(
        max_length=255, blank=True,
        verbose_name='GitHub username', help_text='Optional. Write it without the @.'
    )
    photo = models.ImageField(
        upload_to='proposals/pyconcz2018/talks/',
        verbose_name='Your photo (not an illustration nor avatar)',
        help_text='It will be published on the website.'
                  '\nIdeal photo is: a head shot, shows only you, has no “filters”'
                  ' applied and is as large and uncompressed as possible.'
                  '\nWe might crop it and change contrast, brightness etc.'
                  ' to fit PyCon CZ visual style.'
    )

    # Public talk info
    title = models.CharField(
        max_length=200, verbose_name='What is the title of your talk?',
        help_text='This will be published everywhere!'
                  ' Make up some catchy title which will attract the audience.'
    )
    abstract = models.TextField(
        verbose_name='Tell the audience about your talk in 1–3 paragraphs (90–200 words)',
        help_text='Introduce the problem your talk will bring a solution to.'
                  ' Then explain why it’s a problem worth solving and use the last paragraph'
                  ' to tell your audience what is your approach to solving it.'
    )
    language = models.CharField(
        max_length=2, choices=LANGUAGES, default='en',
        help_text='English is preferred, but if you feel uncomfortable with it,'
                  ' you can give your talk in Czech or Slovak'
    )
    difficulty = models.CharField(
        max_length=10, choices=DIFFICULTY, default='beginner'
    )
    needs_finaid = models.BooleanField(
        default=False,
        verbose_name='I need financial aid to make this talk possible',
        help_text='Covering travel or accommodation costs etc.'
                  ' Please specify this here and now, otherwise we might'
                  ' not be able to grant you the aid.'
    )
    finaid_details = models.TextField(
        null=True, blank=True,
        verbose_name='Details about required financial aid',
        help_text='Please state explicitly:'
                  '\n1) why you need it,'
                  '\n2) what for and'
                  '\n3) how much in EUR or CZK.'
                  '\nIf you require aid for more items (accommodation, travel costs etc.) '
                  'please state the amount for each item.'
    )
    final_note = models.TextField(
        null=True, blank=True,
        verbose_name='Anything else you want to tell us?'
    )

    def __str__(self):
        return '{s.full_name} - {s.title}'.format(s=self)


class Workshop(EntryBase):
    DIFFICULTY = (
        ('beginner', 'Beginner  (suitable for everyone)'),
        ('advanced', 'Advanced  (requires a high level of Python knowledge)'),
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
        ('xx', 'Something else! (Please leave a note in the abstract)')
    )

    LANGUAGES = (
        ('en', 'English (preferred)'),
        ('cs', 'Czech or Slovak'),
    )

    # Public speaker info

    full_name = models.CharField(
        max_length=200, verbose_name='What’s your name?',
        help_text='This will be published in the schedule,'
                  ' so use a name that you’re comfortable with, or a nickname.'
    )
    email = models.EmailField(
        verbose_name='Your email address',
        help_text='We’ll keep it secret, for internal use only.'
    )
    bio = models.TextField(
        verbose_name='Why are you the right person to talk about the topic you chose?',
        help_text='Tell your audience in first person about anything relevant about you,'
                  ' whether it’s your background, education, experience,'
                  ' current or former employer, hobbies or opensource software you maintain.'
                  '\nTry keeping it between between 50 and 90 words.'
                  '\nYou can of course include anything fun or quirky about yourself.'
    )
    referral_link = models.URLField(
        default='', blank=True,
        verbose_name='Got a video?',
        help_text='If you have a recording of you giving a talk or'
                  ' leading a workshop, you can paste the link here.'
    )
    twitter = models.CharField(
        max_length=255, blank=True,
        verbose_name='Twitter handle', help_text='Optional. Write it without the @.'
    )
    github = models.CharField(
        max_length=255, blank=True,
        verbose_name='GitHub username', help_text='Optional. Write it without the @.'
    )
    photo = models.ImageField(
        upload_to='proposals/pyconcz2018/talks/',
        verbose_name='Your photo (not an illustration nor avatar)',
        help_text='It will be published on the website.'
                  '\nIdeal photo is: a head shot, shows only you, has no “filters”'
                  ' applied and is as large and uncompressed as possible.'
                  '\nWe might crop it and change contrast, brightness etc.'
                  ' to fit PyCon CZ visual style.'
    )

    # Public talk info
    type = models.CharField(
        max_length=10, choices=TYPE, default='sprint',
        help_text='At a workshop, you should present hands-on exercises'
                  ' for participants to learn from. You’ll get a room and'
                  ' a slot in the agenda, and participants will need to register.'
                  '\nAt a sprint, participants help an open-source project – usually by'
                  ' cloning the repo and trying to fix beginner-level issues,'
                  ' while you’ll provide one-to-one mentorship. If several experienced'
                  ' developers are around, sprints are also a good place for serious'
                  ' design discussions. Sprinters only need a table to sit around,'
                  ' reliable wifi, and dedication to do great things!'
    )
    title = models.CharField(
        max_length=200, verbose_name='What is the title of your workshop or sprint?',
        help_text='Public title. What topic/project is it all about?'
    )
    abstract = models.TextField(
        verbose_name='Tell the audience about your talk in 1–3 paragraphs (90–200 words)',
        help_text='Describe your workshop or sprint.'
                  '\nPlease include the requirements: libraries and'
                  ' Python version to be installed, required experience'
                  ' with topics/libraries, etc.'
    )
    language = models.CharField(
        max_length=2, choices=LANGUAGES, default='en'
    )
    difficulty = models.CharField(
        max_length=10, choices=DIFFICULTY, default='beginner'
    )
    length = models.CharField(
        max_length=2, choices=LENGTH, blank=True,
        verbose_name='How much time does your workshop take?',
        help_text='Sprints usually take the whole day,'
                  ' but workshops are organized in smaller blocks.'
                  ' You can also have a full-day workshop with lunch break,'
                  ' but keep in mind that the length could discourage attendees.'
    )

    needs_finaid = models.BooleanField(
        default=False,
        verbose_name='I need financial aid to make this workshop possible',
        help_text='Covering travel or accommodation costs etc.'
                  ' Please specify this here and now, otherwise we might'
                  ' not be able to grant you the aid.'
    )
    finaid_details = models.TextField(
        null=True, blank=True,
        verbose_name='Details about required financial aid',
        help_text='Please state explicitly:'
                  '\n1) why you need it,'
                  '\n2) what for and'
                  '\n3) how much in Euros.'
                  '\nIf you require help for more items (accomodation, travel costs etc.) '
                  'please state the amount for each item.'
    )
    requirements = models.TextField(
        null=True, blank=True,
        verbose_name='Extra requirements',
        help_text='Do you have any special requirements?'
                  ' What do attendees need to bring?'
                  ' Do you need anything more than a room with wifi,'
                  ' standard euro sockets and a projector?'
    )
    final_note = models.TextField(
        null=True, blank=True,
        verbose_name='Anything else you want to tell us?'
    )

    def __str__(self):
        return '[{s.type}] {s.title}'.format(s=self)


class FinancialAid(EntryBase):
    # Public speaker info
    full_name = models.CharField(
        max_length=200, verbose_name='Your name',
    )
    email = models.EmailField(
        help_text='We’ll keep it secret, for internal use only.'
    )
    bio = models.TextField(
        help_text='Tell us a bit about yourself! Who you are, where you are'
                  ' from, and what your experience with Python is.'
                  ' Also include how you are involved in the Python community'
                  ' and how you contribute or plan to contribute to it.'
    )
    amount = models.CharField(
        max_length=255,
        help_text='How much money would you like to receive'
                  ' (please specify currency).'
    )

    purpose = models.TextField(
        help_text='How would you like to use the granted money?'
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
