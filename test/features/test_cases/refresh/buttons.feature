Feature: Refresh buttons
  Pages are refreshed correctly with buttons using button_to

  @javascript
  Scenario: Refresh just the page content with JavaScript enabled
    Given I am on the home page
    When I click the button "Page1" from "Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Page1" should be "1"

  Scenario: Refresh just the page content with JavaScript disabled
    Given I am on the home page
    When I click the button "Page1" from "Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"

  @javascript
  Scenario: Refresh all the page content when rails-ajax is disabled with JavaScript enabled
    Given I am on the home page
    When I click the button "Page1" from "no rails-ajax Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"

  Scenario: Refresh all the page content when rails-ajax is disabled with JavaScript disabled
    Given I am on the home page
    When I click the button "Page1" from "no rails-ajax Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"

  @javascript @no_rails3
  Scenario: Refresh just the page content using the block syntax with JavaScript enabled
    Given I am on the home page
    When I click the button "Page1" from "block Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Page1" should be "1"

  @no_rails3
  Scenario: Refresh just the page content using the block syntax with JavaScript disabled
    Given I am on the home page
    When I click the button "Page1" from "block Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"

  @javascript
  Scenario: Do not use Ajax when a target is specified in the link with JavaScript enabled
    Given I am on the home page
    When I click the button "Page1" from "targeted Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"

  Scenario: Do not use Ajax when a target is specified in the link with JavaScript disabled
    Given I am on the home page
    When I click the button "Page1" from "targeted Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"
