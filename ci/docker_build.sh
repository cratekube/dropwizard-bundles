#!/bin/bash

set -o nounset
set -o errexit

## common build args for TravisCI builds
TRAVIS_BUILDARGS=(--build-arg "TRAVIS=${TRAVIS}" --build-arg "TRAVIS_JOB_ID=${TRAVIS_JOB_ID}")

echo "[travis_docker_build] running base docker build"
docker build "${TRAVIS_BUILDARGS[@]}" --target build .
