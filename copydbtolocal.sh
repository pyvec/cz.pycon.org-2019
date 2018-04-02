ssh cz.pycon.org 'pg_dump -h store4.rosti.cz -U czpyconorg_199402 czpyconorg_199402 > dump.sql'
scp cz.pycon.org:dump.sql /tmp/czpyconorgdump.sql
sed -i 's/czpyconorg_199402/pycon2018/g' /tmp/czpyconorgdump.sql
echo 'drop owned by pycon2018;' | psql -h127.0.0.1 -U pycon2018 -d pycon2018
psql -h 127.0.0.1 -U pycon2018 -d pycon2018 < /tmp/czpyconorgdump.sql

