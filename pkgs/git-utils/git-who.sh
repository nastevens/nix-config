#!/bin/sh

REVISIONS=$(git rev-list --no-merges "${1:-HEAD}")

echo "Recent:"
# shellcheck disable=SC2086 # Intended splitting of revs
git log \
    --max-count 10 \
    --pretty="%cd|%an <%ae>" \
    --date=short \
    $REVISIONS \
    | uniq \
    | column \
        --table \
        --separator '|' \
    | sed 's/^/  /'

echo
echo "Top Committers:"
# shellcheck disable=SC2086 # Intended splitting of revs
git log \
    --pretty="|%an <%ae>" \
    $REVISIONS \
    | huniq \
        --count \
        --sort-descending \
    | column \
        --table \
        --separator '|' \
    | head -n 10 \
    | sed 's/^/  /'
