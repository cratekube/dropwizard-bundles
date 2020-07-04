######################
##   build target   ##
######################
FROM openjdk:8u212-jdk-alpine3.9 as build

WORKDIR /app

COPY gradle/wrapper ./gradle/wrapper
COPY gradlew ./
RUN ./gradlew --no-daemon --version

COPY build.gradle gradle.properties settings.gradle ./
COPY gradle/*.gradle ./gradle/
COPY .git ./.git/

## Compile all subprojects, invalidate only if the source changes
COPY subprojects ./subprojects
RUN ./gradlew --no-daemon assemble

## run the static analysis and tests
COPY codenarc.groovy ./
RUN ./gradlew --no-daemon check

## build args required for coveralls reporting
ARG TRAVIS
ARG TRAVIS_JOB_ID

## run code coverage report, send to coveralls when executing in Travis CI
RUN ./gradlew --no-daemon jacocoTestReport coveralls

######################
##  publish target  ##
######################
FROM build as publish

## setup args needed for bintray tasks
ARG APP_VERSION
ARG JFROG_DEPLOY_USER
ARG JFROG_DEPLOY_KEY
ARG BINTRAY_PUBLISH

COPY ci/maven_publish.sh ./
RUN ./maven_publish.sh
