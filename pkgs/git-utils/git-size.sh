#!/bin/sh

# https://stackoverflow.com/a/42544963
git rev-list --objects --all \
    | git cat-file --batch-check='%(objecttype)|%(objectname)|%(objectsize)|%(rest)' \
    | sed -n 's/^blob|//p' \
    | sort --numeric-sort --key=2 --reverse --field-separator='|' \
    | cut -c 1-12,41- \
    | numfmt --delimiter='|' --field=2 --to=iec-i --suffix=B --round=nearest \
    | column --table --separator='|'
