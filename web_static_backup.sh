#!/bin/bash

# Make a static copy of pycon.cz website before a new year edition

if [ -z $1 ]; then
    echo "First argument has to be a year to backup (2018 for example)"
    exit 1
fi

wget \
    --recursive \
    --page-requisites \
    --html-extension \
    --convert-links \
    --domains cz.pycon.org \
    --no-parent \
        cz.pycon.org/$1

mv cz.pycon.org/$1 $1
mv cz.pycon.org/$1.html $1/index.html
mv cz.pycon.org/media $1/
