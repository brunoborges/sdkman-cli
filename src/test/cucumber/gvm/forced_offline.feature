Feature: Forced Offline Mode

  #offline modes
  Scenario: Enter an invalid offline mode
    Given offline mode is disabled
    And the internet is reachable
    And I enter "gvm offline grails"
    Then I see "Stop! grails is not a valid offline mode."

  Scenario: Enable Offline Mode with internet reachable
    Given offline mode is disabled
    And the internet is reachable
    When I enter "gvm offline enable"
    Then I see "AEROPLANE MODE ENABLED!"
    When I enter "gvm install grails 2.1.0"
    Then I see "Stop! grails 2.1.0 is not available in aeroplane mode."

  Scenario: Disable Offline Mode with internet reachable
    Given offline mode is enabled
    And the internet is reachable
    When I enter "gvm offline disable"
    Then I see "Online mode re-enabled!"
    When I enter "gvm install grails 2.1.0" and answer "Y"
    Then I see "Done installing!"
    And the candidate "grails" version "2.1.0" is installed

  Scenario: Disable Offline Mode with internet unreachable
    Given offline mode is enabled
    And the internet is not reachable
    When I enter "gvm offline disable"
    Then I see "Online mode re-enabled!"
    When I enter "gvm install grails 2.1.0"
    Then I see "AEROPLANE MODE ENABLED!"
    And I see "Stop! grails 2.1.0 is not available in aeroplane mode."

  #broadcast
  Scenario: Recall a broadcast while Forced Offline
    Given offline mode is disabled
    And the internet is reachable
    When I enter "gvm offline enable"
    Then I see "AEROPLANE MODE ENABLED!"
    When a prior Broadcast "This is an OLD Broadcast!" was issued
    And I enter "gvm broadcast"
    Then I see "This is an OLD Broadcast!"

  #gvm version
  Scenario: Determine the GVM version while Forced Offline
    Given offline mode is disabled
    And the internet is reachable
    When I enter "gvm offline enable"
    Then I see "AEROPLANE MODE ENABLED!"
    When I enter "gvm version"
    Then I see the current gvm version

  #list candidate version
  Scenario: List candidate versions found while Forced Offline
    Given offline mode is disabled
    And the internet is reachable
    When I enter "gvm offline enable"
    Then I see "AEROPLANE MODE ENABLED!"
    When I enter "gvm list grails"
    Then I see "Aeroplane Mode: only showing installed grails versions"

  #use version
  Scenario: Use an uninstalled candidate version while Forced Offline
    Given forced offline mode is enabled
    And the candidate "grails" version "1.3.9" is already installed and default
    And the candidate "grails" version "2.1.0" is not installed
    When I enter "gvm use grails 2.1.0"
    Then I see "Stop! grails 2.1.0 is not available in aeroplane mode."