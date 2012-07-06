Feature: URL
  Browser changes URL in location bar correctly

  @javascript
  Scenario: Browser's location bar follows Ajax links with JavaScript enabled
    Given I am on the home page
    When I click on "Page1" from "Index"
    Then the location URL should be "/page1"
      And the refresh counter "Page1" should be "1"

  Scenario: Browser's location bar follows Ajax links with JavaScript disabled
    Given I am on the home page
    When I click on "Page1" from "Index"
    Then the location URL should be "/page1"
      And the refresh counter "Page1" should be "1"

  @javascript
  Scenario: Browser's location bar follows Ajax forms with JavaScript enabled
    Given I am on the home page
    When I submit "String1" using "IndexButton1"
    Then the location URL should be "/page1"
      And the refresh counter "Page1" should be "1"

  Scenario: Browser's location bar follows Ajax forms with JavaScript disabled
    Given I am on the home page
    When I submit "String1" using "IndexButton1"
    Then the location URL should be "/page1"
      And the refresh counter "Page1" should be "1"

  @javascript
  Scenario: Browser's location bar follows Ajax links with anchors with JavaScript enabled
    Given I am on the home page
    When I click on "page_with_anchor" from "Index with anchor"
    # TODO (History.js): When History.js will handle correctly anchors, the location should be "/page_with_anchor#Anchor"
    Then the location URL should be "/page_with_anchor"
      And the refresh counter "page_with_anchor" should be "1"

  Scenario: Browser's location bar follows Ajax links with anchors with JavaScript disabled
    Given I am on the home page
    When I click on "page_with_anchor" from "Index with anchor"
    # TODO (Capybara): Capybara removes hash parts of current urls. When this will be corrected, the location should be "/page_with_anchor#Anchor"
    Then the location URL should be "/page_with_anchor"
      And the refresh counter "page_with_anchor" should be "1"

  @javascript
  Scenario: Browser's location bar follows Ajax forms with anchors with JavaScript enabled
    Given I am on the home page
    When I submit "String1" in "Text field to page 3 with anchor" using "IndexButton7"
    # TODO (History.js): When History.js will handle correctly anchors, the location should be "/page_with_anchor#Anchor"
    Then the location URL should be "/page_with_anchor"
      And the refresh counter "page_with_anchor" should be "1"

  Scenario: Browser's location bar follows Ajax forms with anchors with JavaScript disabled
    Given I am on the home page
    When I submit "String1" in "Text field to page 3 with anchor" using "IndexButton7"
    # TODO (Capybara): Capybara removes hash parts of current urls. When this will be corrected, the location should be "/page_with_anchor#Anchor"
    Then the location URL should be "/page_with_anchor"
      And the refresh counter "page_with_anchor" should be "1"
