Feature: Handle user Ajax links
  Rails-Ajax should not mess with user specified Ajax

  @javascript
  Scenario: Make a standard Ajax call with Rails route enforcing JSON format
    Given I am on the home page
    When I make the Ajax call number "1"
    Then the filled Ajax content should be number "1"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"

  @javascript
  Scenario: Make a standard Ajax call with Rails controller enforcing JSON format
    Given I am on the home page
    When I make the Ajax call number "2"
    Then the filled Ajax content should be number "2"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"

  @javascript
  Scenario: Make a JavaScript Ajax call
    Given I am on the home page
    When I make the Ajax call number "3"
    Then the filled Ajax content should be number "3"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"

  @javascript
  Scenario: Make a JavaScript Ajax call using link_to_function
    Given I am on the home page
    When I make the Ajax call number "4"
    Then the filled Ajax content should be number "4"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"

  @javascript
  Scenario: Make a standard Ajax call with Rails controller using render with json object
    Given I am on the home page
    When I make the Ajax call number "5"
    Then the filled Ajax content should be number "5"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"

  @javascript
  Scenario: Make a standard Ajax call with Rails route enforcing JSON format using forms
    Given I am on the home page
    When I make the Ajax form call number "1"
    Then the filled Ajax content should be number "1"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"

  @javascript
  Scenario: Make a standard Ajax call with Rails controller enforcing JSON format using forms
    Given I am on the home page
    When I make the Ajax form call number "2"
    Then the filled Ajax content should be number "2"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"

  @javascript
  Scenario: Make a JavaScript Ajax call using forms
    Given I am on the home page
    When I make the Ajax form call number "3"
    Then the filled Ajax content should be number "3"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"

  @javascript
  Scenario: Make a standard Ajax call with Rails controller using render with json object using forms
    Given I am on the home page
    When I make the Ajax form call number "5"
    Then the filled Ajax content should be number "5"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"

  @javascript
  Scenario: Use a link with a specified onclick event
    Given I am on the home page
    When I make the Ajax call number "6"
    Then the filled Ajax content should be number "6"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"

  @javascript
  Scenario: Use a form with a specified onclick event
    Given I am on the home page
    When I make the Ajax form call number "6"
    Then the filled Ajax content should be number "6"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"
