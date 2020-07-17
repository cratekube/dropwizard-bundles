#!/bin/bash

set -o nounset
set -o errexit

## setup different build args if the build is for a snapshot or a tag
echo "[travis_deploy] uploading maven artifact snapshot"
docker build --build-arg "TRAVIS=${TRAVIS}" --build-arg "TRAVIS_JOB_ID=${TRAVIS_JOB_ID}" \
             --build-arg "JFROG_DEPLOY_USER=${JFROG_DEPLOY_USER}" --build-arg "JFROG_DEPLOY_KEY=${JFROG_DEPLOY_KEY}" \
             --build-arg BINTRAY_PUBLISH=true --build-arg "APP_VERSION=${TRAVIS_TAG}" \
             --target publish .
