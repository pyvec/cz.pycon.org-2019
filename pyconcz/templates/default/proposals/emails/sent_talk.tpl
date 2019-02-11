{% load verbose_names %}
Dear {{ proposal.full_name }}

Thank you for sending us your talk proposal!

All submissions will be scored after Call for Papers ends.
The whole process takes some time and after it ends we’ll let you know to this e-mail.

If you have any questions, don’t hesitate to contact us at info@pycon.cz

Copy of your submission is included bellow:

{{ proposal.language|verbose_name }}
{{ proposal.language }} {% comment %} display 'English (preferred at PyCon CZ)' or 'Czech or Slovak'{% endcomment %}

{{ proposal.title|verbose_name }}
{{ proposal.title }}

{{ proposal.abstract|verbose_name }}
{{ proposal.abstract }}

{{ proposal.difficulty|verbose_name }}
{{ proposal.difficulty }} {% comment %}display 'Beginner  (suitable for everyone)' or …{% endcomment %}

{{ proposal.full_name|verbose_name }}
{{ proposal.full_name }}

{{ proposal.bio|verbose_name }}
{{ proposal.bio }}

{{ proposal.twitter|verbose_name }}
{{ proposal.twitter|default:"not provided" }}

{{ proposal.github|verbose_name }}
{{ proposal.github|default:"not provided" }}

{{ proposal.referral_link|verbose_name }}
{{ proposal.referral_link|default:"not provided" }}
{% if proposal.needs_finaid %}
You required financial aid
{% if proposal.finaid_details %}with the following details:{% else %}without providing details.{% endif %}
{{ proposal.finaid_details }}
{% endif %}
{% if proposal.final_note %}Final note:
{{ proposal.final_note }}{% endif %}


Take care,
PyCon CZ 2019 team
