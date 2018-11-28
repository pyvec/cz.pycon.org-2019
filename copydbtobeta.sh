#!/bin/bash

ssh cz.pycon.org 'pg_dump -h store4.rosti.cz -U pyvec_os1471 pyvec_os1471 > dump.sql'
scp cz.pycon.org:dump.sql /tmp/czpyconorgdump.sql
sed -i 's/pyvec_os1471/pyvec_os1472/g' /tmp/czpyconorgdump.sql
scp /tmp/czpyconorgdump.sql betapycon.org:dump.sql
ssh betapycon.org "echo 'drop owned by pyvec_os1472;' | psql -h store4.rosti.cz -U pyvec_os1472 -d pyvec_os1472"
ssh betapycon.org "psql -h store4.rosti.cz -U pyvec_os1472 -d pyvec_os1472 < dump.sql"

