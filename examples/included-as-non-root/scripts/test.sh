#!/bin/bash
set -e # fail on error
#
# Run in examples/included-as-non-root directory
#


if [ "$GITHUB_ACTIONS" = "true" ]; then
    id
    stat .
    ls -al
    export DOCKER_USER=node # GitHub runner non-root user
else
    export DOCKER_USER=node # Cypress Docker image non-root user
fi
echo Test cypress/included running under $DOCKER_USER \(non-root\) user
docker run --rm -v .:/test -w /test -u $DOCKER_USER cypress/included
