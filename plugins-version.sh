#!/bin/bash -u
#
# Retrieve latest version of Jenkins plugins listed in the Dockerfile.
#
set -o pipefail

latest_versions() {
  curl -sL https://updates.jenkins.io/experimental/update-center.actual.json \
    | jq -r '.plugins[] | .name + ":" + .version'
}

list_plugins() {
  grep -o " [a-z\-]*:[0-9a-z][0-9a-z\.\-]*" Dockerfile
}

main() {
  latestVersions=$(latest_versions)
  currentVersions="$(list_plugins)"
  plugins="$(list_plugins | sed "s/:.*//")"

  while read plugin; do

    latestPlugin=$(grep -E "^${plugin}:" <<< "$latestVersions")

    grep -E "^${plugin}:" <<< "$latestVersions" > /dev/null \
      && (
        grep -E "${latestPlugin}" <<< "$currentVersions" > /dev/null \
          &&
        echo "[OK] Plugin ${latestPlugin}" \
          ||
        echo "[WARNING] Plugin ${plugin} out of date (latest: ${latestPlugin}) "
      ) \
      || echo "[ERROR] Plugin ${plugin} not found"

  done <<< "$plugins"
}

main

