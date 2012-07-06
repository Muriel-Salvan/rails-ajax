Feature: Redirect
  Browser redirects correctly without refreshing the layout

  @javascript
  Scenario: Simple redirect with JavaScript enabled
    Given I am on the home page
    When I click on "Redirect" from "Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Page1" should be "1"
      And the location URL should be "/page1"

  Scenario: Simple redirect with JavaScript disabled
    Given I am on the home page
    When I click on "Redirect" from "Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"
      And the location URL should be "/page1"

  @javascript
  Scenario: Simple redirect using a form with JavaScript enabled
    Given I am on the home page
    When I submit "String1" in "Text field to redirect" using "IndexButton9"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Page1" should be "1"
      And the location URL should be "/page1"

  Scenario: Simple redirect using a form with JavaScript disabled
    Given I am on the home page
    When I submit "String1" in "Text field to redirect" using "IndexButton9"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"
      And the location URL should be "/page1"
