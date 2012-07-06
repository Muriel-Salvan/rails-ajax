Feature: Script
  Execute scripts correctly when RailsAjax is activated

  @javascript @trap_alerts
  Scenario: Execute specifically a script on a page loaded using RailsAjax only, with JavaScript enabled
    Given I am on the home page
    When I click on "page_with_railsajax_javascript" from "Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "page_with_railsajax_javascript" should be "1"
      And "Javascript executed from page_with_railsajax_javascript" should have popped

  Scenario: Execute specifically a script on a page loaded using RailsAjax only, with JavaScript disabled
    Given I am on the home page
    When I click on "page_with_railsajax_javascript" from "Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "page_with_railsajax_javascript" should be "1"

  @javascript @trap_alerts
  Scenario: Load a page that has a script to be executed, with JavaScript enabled
    Given I am on the home page
    When I click on "page_with_javascript" from "Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "page_with_javascript" should be "1"
      And "Javascript executed from page_with_javascript" should have popped

  Scenario: Load a page that has a script to be executed, with JavaScript disabled
    Given I am on the home page
    When I click on "page_with_javascript" from "Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "page_with_javascript" should be "1"

  @javascript @trap_alerts
  Scenario: Load a page that has a script to be executed during jQuery ready handler, with JavaScript enabled
    Given I am on the home page
    When I click on "page_with_jquery_ready" from "Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "page_with_jquery_ready" should be "1"
      And "Javascript executed from page_with_jquery_ready" should have popped

  Scenario: Load a page that has a script to be executed during jQuery ready handler, with JavaScript disabled
    Given I am on the home page
    When I click on "page_with_jquery_ready" from "Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "page_with_jquery_ready" should be "1"
