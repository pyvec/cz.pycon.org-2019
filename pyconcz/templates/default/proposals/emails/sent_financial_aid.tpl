{% load verbose_names %}
Dear {{ proposal.full_name }}!

We’ve received your Financial Aid application.

We’ll inform you by e-mail about the result before the end of May whether your application will be successfull or not.

While we might not be able cover all expenses for everyone, we’ll try our best to help you as much as our budget will allow.

If you have any questions, don’t hesitate to contact us at info@pycon.cz


Copy of your request is included bellow:

{{ proposal.amount|verbose_name }}
{{ proposal.amount }}

{{ proposal.purpose|verbose_name }}
{{ proposal.purpose }}

{{ proposal.python_involvement|verbose_name }}
{{ proposal.python_involvement }}

{{ proposal.community_involvement|verbose_name }}
{{ proposal.community_involvement|default:"not provided" }}


Take care,
PyCon CZ 2019 team
