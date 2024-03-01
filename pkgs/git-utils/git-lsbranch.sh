#!/bin/sh

for k in $(git branch "$@" | sed -r -e 's/^..//;s/ .*$//' | sort); do
    git show \
        --no-patch \
        --color="always" \
        --pretty="%Cgreen%cr|%Cblue%h|%Creset%s|%C(yellow)$k%Creset%n" \
        "$k"
done \
    | column \
        --table \
        --separator '|' \
        --table-truncate 3
