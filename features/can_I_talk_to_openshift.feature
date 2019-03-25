Feature: Can I talk to OpenShift?
  I want to know if I can communicate with the OpenShift cluster

  Scenario: Use `oc` command-line client to get username
    Given an installed OpenShift client
    When I run `oc whoami`
    Then I should see a username returned