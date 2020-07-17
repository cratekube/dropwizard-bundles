package io.cratekube.dropwizard.auth

import spock.lang.Specification
import spock.lang.Subject

import static io.cratekube.dropwizard.auth.Fixtures.TEST_KEY
import static io.cratekube.dropwizard.auth.Fixtures.TEST_USER
import static org.hamcrest.Matchers.empty
import static org.hamcrest.Matchers.equalTo
import static spock.util.matcher.HamcrestSupport.expect

class ApiKeyAuthenticatorSpec extends Specification {
  @Subject ApiKeyAuthenticator<User> subject
  ApiKeyProvider apiKeyProvider
  UserFactory<ApiKey, User> userFactory

  def setup() {
    apiKeyProvider = Stub()
    userFactory = Stub()
    subject = new ApiKeyAuthenticator(apiKeyProvider, userFactory)
  }

  def 'should require valid constructor parameters'() {
    when:
    new ApiKeyAuthenticator(keyProvider, usrFactory)

    then:
    thrown NullPointerException

    where:
    keyProvider         | usrFactory
    null                | null
    this.apiKeyProvider | null
  }

  def 'should return empty optional when apikey provider returns a null'() {
    given:
    apiKeyProvider.get(TEST_KEY) >> null

    when:
    def result = subject.authenticate(TEST_KEY)

    then:
    expect result.isPresent(), equalTo(false)
  }

  def 'should return populate optional when apikey provider returns an object'() {
    given:
    def apiKey = new ApiKey(name: 'test-key', key: TEST_KEY, roles: [])
    apiKeyProvider.get(TEST_KEY) >> apiKey
    userFactory.create(apiKey) >> TEST_USER

    when:
    def result = subject.authenticate(TEST_KEY)

    then:
    expect result.isPresent(), equalTo(true)
    verifyAll(result.get()) {
      expect name, equalTo('test-user')
      expect roles, empty()
    }
  }
}
