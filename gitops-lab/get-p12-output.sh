#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

CERT=$(openssl pkcs12 -info -in $1 -nodes -nokeys -passin pass:$2 | base64)
KEY=$(openssl pkcs12 -info -in $1 -nodes -nocerts -passin pass:$2 | base64)

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
jq -n --arg CERT "$CERT" --arg KEY "$KEY" '{"cert":$CERT, "key":$KEY}'