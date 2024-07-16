#!/bin/bash
envsubst "$(printf '${%s} ' $(env | cut -d'=' -f1))"

tempfile=$(mktemp)
envsubst "$(printf '${%s} ' $(env | cut -d'=' -f1))" < /etc/opensips/opensips-cli.cfg > "$tempfile"

mv "$tempfile" /etc/opensips/opensips-cli.cfg
