#!/bin/bash

set -x
# Get script parameters
eval "$(jq -r '@sh "PARAM_OUTPUT_LOCATION=\(.output_location)
PARAM_HOST=\(.host)
PARAM_USER=\(.user)
PARAM_PASSWORD=\(.password)"')"

jq --raw-output '.' $PARAM_OUTPUT_LOCATION