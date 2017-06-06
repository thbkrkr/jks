#!/bin/bash -eu

if [[ "${REGISTRY_AUTH:-}" != "" ]]; then
  mkdir -p ~/.docker
  base64 -d <<< $REGISTRY_AUTH > ~/.docker/config.json
fi

if [[ "${SEED_CREDS:-}" != "" ]]; then
  mkdir -p /usr/share/jenkins/keys
  export SEED_CREDS_ID=$(cut -d ':' -f1 <<< $SEED_CREDS)
  cut -d ':' -f2 <<< $SEED_CREDS | base64 -d > /usr/share/jenkins/keys/$SEED_CREDS_ID
fi

exec /bin/tini -- /usr/local/bin/jenkins.sh