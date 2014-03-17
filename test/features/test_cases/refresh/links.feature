Feature: Refresh links
  Pages are refreshed correctly with links using Ajax only when JavaScript is enabled

  @javascript
  Scenario: Refresh just the page content with JavaScript enabled
    Given I am on the home page
    When I click on "Page1" from "Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Page1" should be "1"

  Scenario: Refresh just the page content with JavaScript disabled
    Given I am on the home page
    When I click on "Page1" from "Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"

  @javascript
  Scenario: Refresh all the page content when rails-ajax is disabled with JavaScript enabled
    Given I am on the home page
    When I click on "Page1" from "no rails-ajax Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"

  Scenario: Refresh all the page content when rails-ajax is disabled with JavaScript disabled
    Given I am on the home page
    When I click on "Page1" from "no rails-ajax Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"

  @javascript
  Scenario: Refresh just the page content using the block syntax with JavaScript enabled
    Given I am on the home page
    When I click on "Page1" from "block Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Page1" should be "1"

  Scenario: Refresh just the page content using the block syntax with JavaScript disabled
    Given I am on the home page
    When I click on "Page1" from "block Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"

  @javascript
  Scenario: Refresh just the page content from a layout link with JavaScript enabled
    Given I am on the home page
    When I click on "Page1" from "Layout"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Page1" should be "1"

  Scenario: Refresh just the page content from a layout link with JavaScript disabled
    Given I am on the home page
    When I click on "Page1" from "Layout"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"

  @javascript
  Scenario: Refresh just the page content using a link given from a previous Ajax call with JavaScript enabled
    Given I am on the home page
    When I click on "Page1" from "Index"
      And I click on "Index" from "Page1"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "2"

  Scenario: Refresh just the page content using a link given from a previous Ajax call with JavaScript disabled
    Given I am on the home page
    When I click on "Page1" from "Index"
      And I click on "Index" from "Page1"
    Then the refresh counter "Layout" should be "3"
      And the refresh counter "Index" should be "2"

  @javascript
  Scenario: Do not use Ajax when a target is specified in the link with JavaScript enabled
    Given I am on the home page
    When I click on "Page1" from "targeted Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"

  Scenario: Do not use Ajax when a target is specified in the link with JavaScript disabled
    Given I am on the home page
    When I click on "Page1" from "targeted Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"

  @javascript
  Scenario: Check that without scrolling, the bottom element is not visible with JavaScript enabled
    Given I am on the home page
    When I click on "page_with_anchor" from "Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "page_with_anchor" should be "1"
      And element "page_with_anchor_Bottom" should not be visible

  @javascript
  Scenario: Scroll the window to an anchor if needed with JavaScript enabled
    Given I am on the home page
    When I click on "page_with_anchor" from "anchored Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "page_with_anchor" should be "1"
      And element "page_with_anchor_Bottom" should be visible

  @javascript
  Scenario: Entering a direct URL in the browser just refreshes the page once with JavaScript enabled
    Given I am on the home page
    When I manually enter URL "/page1"
    Then the refresh counter "Page1" should be "1"
      And the refresh counter "Layout" should be "2"
      And the location URL should be "/page1"

  Scenario: Entering a direct URL in the browser just refreshes the page once with JavaScript disabled
    Given I am on the home page
    When I manually enter URL "/page1"
    Then the refresh counter "Page1" should be "1"
      And the refresh counter "Layout" should be "2"
      And the location URL should be "/page1"

  @javascript
  Scenario: Navigating after entering a direct URL refreshes the page once with JavaScript enabled
    Given I am on the home page
    When I manually enter URL "/page1"
      And I click on "Page2" from "Page1"
    Then the refresh counter "Page2" should be "1"
      And the refresh counter "Layout" should be "2"
      And the location URL should be "/page2"

  Scenario: Navigating after entering a direct URL refreshes the page once with JavaScript disabled
    Given I am on the home page
    When I manually enter URL "/page1"
      And I click on "Page2" from "Page1"
    Then the refresh counter "Page2" should be "1"
      And the refresh counter "Layout" should be "3"
      And the location URL should be "/page2"

  @javascript
  Scenario: Displays 404 error correctly with JavaScript enabled
    Given I am on the home page
    When I click on "Error404" from "Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Error404" should be "1"
      And the location URL should be "/error404"

  Scenario: Displays 404 error correctly with JavaScript disabled
    Given I am on the home page
    When I click on "Error404" from "Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Error404" should be "1"
      And the location URL should be "/error404"
