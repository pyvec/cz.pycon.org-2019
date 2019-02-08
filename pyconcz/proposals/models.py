# coding=utf-8

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

    value = models.DecimalField(max_digits=2,
                                decimal_places=1,
                                null=True,
                                blank=True,
                                help_text='4 = Must have!, 3 = Interesting talk, '
                                          '2 = Meh, 1 = Definitely not!, '
                                          'blank value = No score (f.e. your proposal); '
                                          'you can also use decimals',
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
    note = models.TextField(blank=True, default='')
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
        ('advanced', 'Advanced  (requires a higher level of Python knowledge)'),
    )

    LANGUAGES = (
        ('en', 'English (preferred at PyCon CZ)'),
        ('cs', 'Czech or Slovak'),
    )

    # Public speaker info
    full_name = models.CharField(
        max_length=200, verbose_name='What’s your name?',
        help_text='Use a name that you’re comfortable with, or a nickname.'
                  '\nFeel free to use Unicode characters.'
    )
    email = models.EmailField(
        verbose_name='Your email address',
        help_text='We’ll keep it secret and use only to contact you.'
    )
    bio = models.TextField(
        verbose_name='Why are you the right person to talk about the topic you chose?'
                     ' (between 50 and 90 words)',
        help_text='Tell your audience in first person (e.g. „I write…“ not „Alex writes…“ ) '
                  'about anything relevant about you, whether it’s your background, '
                  'education, experience, current or former employer, hobbies '
                  'or opensource software you maintain.'
                  '\nYou can of course include anything fun or quirky about yourself.'
    )
    referral_link = models.URLField(
        default='', blank=True,
        verbose_name='Got a video?',
        help_text='If you have a link to a publicly available recording of you'
                  ' giving a talk or leading a workshop, you can paste the link here. '
                  '\nWill be used in the decision process.'
    )
    twitter = models.CharField(
        max_length=255, blank=True,
        verbose_name='Your Twitter handle', help_text='Optional. Write it without the @.'
    )
    github = models.URLField(
        default='', blank=True,
        verbose_name='Your public code repository (GitHub, GitLab, …)', help_text='Optional. The whole URL.'
    )
    photo = models.ImageField(
        upload_to='proposals/pyconcz2019/talks/',
        verbose_name='Your photo (not an illustration nor avatar)',
        help_text='If you don’t have a photo according to specs below, we will ask you for one if your talk is selected.'
                  '\nIdeal photo is:'
                  '\n– as large as possible'
                  ' (128 × 128 px, there is no upper limit, even 1000 × 1000 px isn’t too much),'
                  '\n– as uncompressed as possible (JPEGs are ok),'
                  '\n– doesn’t show other people'
                  '\n– is a head shot (not you in front of a pyramid)'
                  '\n– and has no “creative filters” applied.'
                  '\nWe might crop it and change contrast, brightness etc. to fit PyCon CZ visual style.'
    )

    # Public talk info
    title = models.CharField(
        max_length=200, verbose_name='Title of your talk',
        help_text='The shortest way to say what it will be about.'
    )
    abstract = models.TextField(
        verbose_name='Tell the audience more about your talk in 1–3 paragraphs (90–200 words total)',
        help_text='Try to write as if you’re talking to a real person.'
                  '\nUse plain text or Markdown.'
                  '\n\nYou might want to follow these guidelines:'
                  '\nFirst introduce the problem your talk will bring a solution to.'
                  '\nThen explain why it’s a problem worth solving.'
                  '\nUse the last paragraph to tell your audience what is your '
                  'approach to solving it.'

    )
    language = models.CharField(
        max_length=2, verbose_name='Talk language',
        choices=LANGUAGES, default='en',
        help_text='English is preferred, but if you feel uncomfortable with it,'
                  ' you can give your talk in Czech or Slovak'
    )
    difficulty = models.CharField(
        max_length=10, verbose_name='Talk difficulty',
        choices=DIFFICULTY, default='beginner'
    )
    needs_finaid = models.BooleanField(
        default=False,
        verbose_name='I need financial aid to make this talk possible',
        help_text='Covering travel or accommodation costs etc.'
                  '\nPlease specify this here and now, otherwise we might'
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
    gdpr_consent = models.BooleanField(
        default=False, blank=False,
        verbose_name='I have read and agree to the PyCon CZ Privacy Policy and Code of Conduct',
        # Please change this, if you know how to do it better (place HTML tags to verbose_name?)
        help_text='<a href="/2019/about/privacy/">Privacy Policy</a> and <a href="/2019/about/code/">Code of Conduct</a>',
    )
    is_backup = models.BooleanField(default=False)
    is_keynote = models.BooleanField(default=False)

    def __str__(self):
        return '{s.full_name} - {s.title}'.format(s=self)


class Workshop(EntryBase):
    DIFFICULTY = (
        ('beginner', 'Beginner  (suitable for everyone)'),
        ('advanced', 'Advanced  (requires a higher level of Python knowledge)'),
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
        ('en', 'English (preferred at PyCon CZ)'),
        ('cs', 'Czech or Slovak'),
    )

    # Public speaker info
    full_name = models.CharField(
        max_length=200, verbose_name='What’s your name?',
        help_text='Use a name that you’re comfortable with, or a nickname.'
                  '\nFeel free to use Unicode characters.'
    )
    email = models.EmailField(
        verbose_name='Your email address',
        help_text='We’ll keep it secret and use only to contact you.'
    )
    bio = models.TextField(
        verbose_name='Why are you the right person to lead a workshop about the topic you chose?'
                     ' (between 50 and 90 words)',
        help_text='Tell your audience in first person (e.g. „I write…“ not „Alex writes…“ ) '
                  'about anything relevant about you, whether it’s your background, '
                  'education, experience, current or former employer, hobbies '
                  'or opensource software you maintain.'
                  '\nYou can of course include anything fun or quirky about yourself.'
    )
    referral_link = models.URLField(
        default='', blank=True,
        verbose_name='Got a video?',
        help_text='If you have a link to a publicly available recording of you'
                  ' giving a talk or leading a workshop, you can paste the link'
                  ' here. Will be used in the decision process.'
    )
    twitter = models.CharField(
        max_length=255, blank=True,
        verbose_name='Your Twitter handle', help_text='Optional. Write it without the @.'
    )
    github = models.URLField(
        default='', blank=True,
        verbose_name='Your public code repository (GitHub, GitLab, …)', help_text='Optional. The whole URL.'
    )
    photo = models.ImageField(
        upload_to='proposals/pyconcz2019/talks/',
        verbose_name='Your photo (not an illustration nor avatar)',
        help_text='If you don’t have a photo according to specs below, we will ask you for one if your workshop is selected.'
                  '\nIdeal photo is:'
                  '\n– as large as possible'
                  ' (128 × 128 px, there is no upper limit, even 1000 × 1000 px isn’t too much),'
                  '\n– as uncompressed as possible (JPEGs are ok),'
                  '\n– doesn’t show other people'
                  '\n– is a head shot (not you in front of a pyramid)'
                  '\n– and has no “creative filters” applied.'
                  '\nWe might crop it and change contrast, brightness etc. to fit PyCon CZ visual style.'
    )

    # Public talk info
    type = models.CharField(
        max_length=10, choices=TYPE, default='workshop',
        verbose_name='Choose a type',
        help_text='At a workshop, you should present hands-on exercises'
                  ' for participants to learn from. You’ll have a room and'
                  ' a limited number of participants.'
                  '\nAt a sprint, participants help an open-source project – usually by'
                  ' cloning the repo and trying to fix beginner-level issues,'
                  ' while you’ll provide one-to-one mentorship. If several experienced'
                  ' developers are around, sprints are also a good place for serious'
                  ' design discussions. Sprinters only need a table to sit around,'
                  ' reliable wifi and dedication to do great things!'
    )
    title = models.CharField(
        max_length=200, verbose_name='What is the title of your workshop or sprint?',
        help_text='The shortest way to say what it will be about.'
    )
    abstract = models.TextField(
        verbose_name='Tell the audience about your workshop or sprint in 1–3 paragraphs (90–200 words)',
        help_text='Try to write as if you’re talking to a real person.'
                  '\nPlease include any requirements: hardware to bring (including laptops),'
                  ' libraries and Python version to be installed,'
                  ' expected experience with topics/libraries, etc.'
                  '\nUse plain text or Markdown.'
    )
    language = models.CharField(
        max_length=2, verbose_name='Workshop or sprint language',
        choices=LANGUAGES, default='en',
        help_text='English is preferred, but if you feel uncomfortable with it,'
                  ' you can hold your workshop in Czech or Slovak'
    )
    difficulty = models.CharField(
        max_length=10, verbose_name='Workshop difficulty',
        choices=DIFFICULTY, default='beginner'
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
                  '\nPlease specify this here and now, otherwise we might'
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
    requirements = models.TextField(
        null=True, blank=True,
        verbose_name='Extra requirements',
        help_text='Do you have any special requirements that you expect us to fullfill?'
                  '\nDo you need anything more than a room with chairs, desks, wifi,'
                  ' standard euro sockets and a projector?'
    )
    final_note = models.TextField(
        null=True, blank=True,
        verbose_name='Anything else you want to tell us?'
    )
    gdpr_consent = models.BooleanField(
        default=False, blank=False,
        verbose_name='I have read and agree to the PyCon CZ Privacy Policy and Code of Conduct',
        # Please change this, if you know how to do it better (place HTML tags to verbose_name?)
        help_text='<a href="/2019/about/privacy/">Privacy Policy</a> and <a href="/2019/about/code/">Code of Conduct</a>',
    )
    is_backup = models.BooleanField(default=False)

    def __str__(self):
        return '[{s.type}] {s.title}'.format(s=self)


class FinancialAid(EntryBase):
    # Public speaker info
    full_name = models.CharField(
        max_length=200, verbose_name='Your name',
    )
    email = models.EmailField(
        verbose_name='Your email address',
        help_text='We’ll send information about your application result to this address.',
    )
    python_involvement = models.CharField(
        null=True, max_length=400,
        verbose_name='What is your connection with Python?',
        help_text='e.g. You’re learning it or teaching it or using for something…',
    )
    community_involvement = models.TextField(
        null=True, blank=True,
        verbose_name='Do you contribute or plan to contribute to Python community in any way? (optional)',
        help_text='It’s a plus but we don’t limit Financial Aid to those who do.',
    )
    purpose = models.TextField(
        verbose_name='What do you need the money for exactly?',
        help_text='If you require help for more items (accomodation, travel costs etc.) '
                  'please state the amount for each of them in Euros.'
                  '\nYou don’t need to specify the price of a ticket.'
                  '\nPlease use following conversion rates: 1 Euro = 25 Czech Korunas = $1.23',
    )
    amount = models.CharField(
        max_length=255,
        verbose_name='How much total money would you like to receive (in Euros)',
        help_text='If you require just a free ticket, please state “ticket”.'
                  '\nPlease use following conversion rates: 1 Euro = 25 Czech Korunas = $1.23',
    )
    gdpr_consent = models.BooleanField(
        default=False, blank=False,
        verbose_name='I have read and agree to the PyCon CZ Privacy Policy and Code of Conduct',
        # Please change this, if you know how to do it better (place HTML tags to verbose_name?)
        help_text=('<a href="/2019/about/privacy/">Privacy Policy</a> and '
                   '<a href="/2019/about/code/">Code of Conduct</a>'),
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
