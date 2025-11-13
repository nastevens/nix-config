#!/bin/sh

SOURCE_PATH="$1"
NEW_NAME=$(
tr '[:upper:] ' '[:lower:]-' << EOF
$SLIC3R_PP_OUTPUT_NAME
EOF
)
echo "$NEW_NAME" > "$SOURCE_PATH.output_name"
