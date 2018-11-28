#!/bin/bash

ssh cz.pycon.org 'pg_dump -h store4.rosti.cz -U pyvec_os1471 pyvec_os1471 > dump.sql'
scp cz.pycon.org:dump.sql /tmp/czpyconorgdump.sql
sed -i 's/pyvec_os1471/pycon2019/g' /tmp/czpyconorgdump.sql
echo 'drop owned by pycon2019;' | psql -h127.0.0.1 -U pycon2019 -d pycon2019
psql -h 127.0.0.1 -U pycon2019 -d pycon2019 < /tmp/czpyconorgdump.sql

