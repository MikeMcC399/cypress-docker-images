#!/bin/bash
set -e # fail on error
#
# Run ./scripts/test-firefox.sh in factory directory
#
ARCHITECTURE=$(uname -m)
echo Running on $ARCHITECTURE

echo Test Firefox
echo Build Factory
docker compose build factory
cd test-project
set -a && . ../.env && set +a

case $ARCHITECTURE in
  x86_64)
    echo Testing browsers in amd64
    echo Build and test with Firefox
      docker build --build-arg FIREFOX_VERSION='134.0' --progress plain -t firefox-134 . # bz2 compression
      docker run --rm --entrypoint bash firefox-134 -c "npx cypress run -b firefox"
      #
      docker build --build-arg FIREFOX_VERSION='135.0' --progress plain -t firefox-135 . # xz compression
      docker run --rm --entrypoint bash firefox-135 -c "npx cypress run -b firefox"
      #
      docker build --build-arg FIREFOX_VERSION='136.0' --progress plain -t firefox-136 . # latest version
      docker run --rm --entrypoint bash firefox-136 -c "npx cypress run -b firefox"
    ;;
  aarch64)
    echo Testing browsers in amd64
    echo Build and test with Firefox
      docker build --build-arg FIREFOX_VERSION='134.0' --progress plain -t firefox-134 . # bz2 compression
      docker run --rm --entrypoint bash firefox-134 -c "npx cypress info"
      #
      docker build --build-arg FIREFOX_VERSION='135.0' --progress plain -t firefox-135 . # xz compression
      docker run --rm --entrypoint bash firefox-135 -c "npx cypress info"
      #
      docker build --build-arg FIREFOX_VERSION='136.0' --progress plain -t firefox-136 . # latest version
      docker run --rm --entrypoint bash firefox-136 -c "npx cypress run -b firefox"
    ;;
  *)
    echo Unsupported architecture
    exit 1
    ;;
esac
