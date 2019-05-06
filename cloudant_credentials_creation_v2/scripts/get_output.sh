#!/bin/bash

set -x
# Get script parameters
eval "$(jq -r '@sh "OUTPUT_LOCATION=\(.output_location)"')"

jq --raw-output '.' $OUTPUT_LOCATION