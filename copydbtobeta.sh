ssh cz.pycon.org 'pg_dump -h store4.rosti.cz -U czpyconorg_199402 czpyconorg_199402 > dump.sql'
scp cz.pycon.org:dump.sql /tmp/czpyconorgdump.sql
sed -i 's/czpyconorg_199402/pycon_beta_217402/g' /tmp/czpyconorgdump.sql
scp /tmp/czpyconorgdump.sql betapycon.org:dump.sql
ssh betapycon.org "echo 'drop owned by pycon_beta_217402;' | psql -h store4.rosti.cz -U pycon_beta_217402 -d pycon_beta_217402"
ssh betapycon.org "psql -h store4.rosti.cz -U pycon_beta_217402 -d pycon_beta_217402 < dump.sql"

