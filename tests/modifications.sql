ALTER SCHEMA pycon2018 RENAME TO pyconcz;

DELETE FROM "django_admin_log";
DELETE FROM "django_migrations";
DELETE FROM "django_session";
DELETE FROM "proposals_score";

DELETE FROM proposals_talk WHERE accepted=FALSE;
UPDATE proposals_talk SET finaid_details='', needs_finaid=FALSE, final_note='';

DELETE FROM proposals_workshop WHERE accepted=FALSE;
UPDATE proposals_workshop SET finaid_details='', needs_finaid=FALSE, final_note='';

UPDATE auth_user SET password='<HASH>'
