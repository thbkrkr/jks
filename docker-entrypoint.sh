#!/bin/bash -eu

if [[ "${REGISTRY_URL:-}" != "" ]]; then
  mkdir -p ~/.docker
  echo '{
      "auths": {
        "'$REGISTRY_URL'": {
            "auth": "'$REGISTRY_AUTH'"
        }
      }
    }' > ~/.docker/config.json
fi

exec /bin/tini -- /usr/local/bin/jenkins.sh