#!/bin/bash
set -e # fail on error
#
# Run in examples/included-as-non-root directory
#
echo Test cypress/included running under node \(non-root\) user
docker run --rm -v ./src:/test -w /test -u node cypress/included
