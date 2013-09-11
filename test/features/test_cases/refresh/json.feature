Feature: Handle user Ajax links
  Rails-Ajax should not mess with user specified Ajax

  @javascript
  Scenario: Make a standard Ajax call with Rails defaults
    Given I am on the home page
    When I make the Ajax call number "1"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"
      And the filled Ajax content should be number "1"

  @javascript
  Scenario: Make a standard Ajax call with Rails route enforcing JSON format
    Given I am on the home page
    When I make the Ajax call number "2"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"
      And the filled Ajax content should be number "2"

  @javascript
  Scenario: Make a standard Ajax call with Rails controller enforcing JSON format
    Given I am on the home page
    When I make the Ajax call number "3"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"
      And the filled Ajax content should be number "3"

  @javascript
  Scenario: Make a jQuery Ajax call
    Given I am on the home page
    When I make the Ajax call number "4"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"
      And the filled Ajax content should be number "4"

  @javascript
  Scenario: Make a jQuery unobtrusive Ajax call
    Given I am on the home page
    When I make the Ajax call number "5"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"
      And the filled Ajax content should be number "5"

  @javascript
  Scenario: Make a JavaScript Ajax call
    Given I am on the home page
    When I make the Ajax call number "6"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"
      And the filled Ajax content should be number "6"

  @javascript
  Scenario: Make a JavaScript Ajax call using link_to_function
    Given I am on the home page
    When I make the Ajax call number "7"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"
      And the filled Ajax content should be number "7"
