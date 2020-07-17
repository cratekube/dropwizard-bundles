# dropwizard-bundles
[![License](http://img.shields.io/badge/license-APACHE-blue.svg?style=flat)](http://choosealicense.com/licenses/apache-2.0/)
[![SemVer](http://img.shields.io/badge/semver-2.0.0-blue.svg?style=flat)](http://semver.org/spec/v2.0.0)
[![Build Status](https://travis-ci.com/cratekube/dropwizard-groovy-template.svg?branch=master)](https://travis-ci.com/cratekube/dropwizard-groovy-template)
[![Coverage Status](https://coveralls.io/repos/github/cratekube/dropwizard-groovy-template/badge.svg?branch=master)](https://coveralls.io/github/cratekube/dropwizard-groovy-template?branch=master)

Repository for custom Dropwizard bundles used in CrateKube repositories

## Dropwizard Bundles

### api-key-auth
The `api-key-auth` bundle provides an extension to Dropwizard authc/authz, allowing you to specify api keys that must
be sent for requests.  Usage of this bundle can be seen in the [ApiKeyAuthBundleSpec](subprojects/api-key-auth/src/test/groovy/io/cratekube/dropwizard/auth/ApiKeyAuthBundleSpec.groovy) 
integration spec.  Multiple keys with associated roles can be configured via a Dropwizard configuration file.

## Local development

### Gradle builds
This project uses [gradle](https://github.com/gradle/gradle) for building and testing.  We also use the gradle wrapper
to avoid downloading a local distribution.  The commands below are helpful for building and testing.
- `./gradlew build` compile and build 
- `./gradlew check` run static code analysis and tests

### Docker builds
We strive to have our builds repeatable across development environments, so we also provide a Docker build to generate 
the Dropwizard application container.  The examples below should be executed from the root of the project.

Running the base docker build:
```bash
docker build --target build .
```

## Importing bundles into your Dropwizard apps
This project generates a maven asset for each subproject.  To use the bundle in your Dropwizard application you will need
to include a dependency using the maven coordinates.  To use a bundle include following dependency in your project:

Gradle:
```groovy
implementation 'io.cratekube.dropwizard-bundles:<subproject-name>:1.0.0'
``` 

Maven:
```xml
<dependency>
  <groupId>io.cratekube.dropwizard-bundles</groupId>
  <artifactId>subproject-name</artifactId>
  <version>1.0.0</version>
</dependency>
```

## Contributing
If you are interested in contributing to this project please review the [contribution guidelines](https://github.com/cratekube/cratekube/blob/master/CONTRIBUTING.md).
Thank you for your interest in CrateKube!
