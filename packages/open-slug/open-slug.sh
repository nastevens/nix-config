#!/bin/sh

URL="$1"
SLUG=$(echo "$2" | tr -d "'\"")
xdg-open "${URL}/${SLUG}"
