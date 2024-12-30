#!/bin/bash
set -e # fail on error
#
# Run in examples/included-as-non-root directory
#
echo Test cypress/included running under node \(non-root\) user

if [ "$GITHUB_ACTIONS" = "true" ]; then
    export DOCKER_USER=1001 # GitHub runner non-root user
else
    export DOCKER_USER=node # Cypress Docker image non-root user
fi

docker run --rm -v .:/test -w /test -u $DOCKER_USER cypress/included
