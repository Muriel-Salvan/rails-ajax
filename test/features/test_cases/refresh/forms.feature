Feature: Refresh forms
  Pages are refreshed correctly with forms using Ajax only when JavaScript is enabled

  @javascript
  Scenario: Refresh just the page content using a form and first button with JavaScript enabled
    Given I am on the home page
    When I submit "String1" using "IndexButton1"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Page1" should be "1"
      And the "Page1" parameter "index_field_1" should be "String1"
      And the "Page1" parameter "commit" should be "IndexButton1"

  Scenario: Refresh just the page content using a form and first button with JavaScript disabled
    Given I am on the home page
    When I submit "String1" using "IndexButton1"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"
      And the "Page1" parameter "index_field_1" should be "String1"
      And the "Page1" parameter "commit" should be "IndexButton1"

  @javascript
  Scenario: Refresh all the page content using a form and first button with rails-ajax disabled with JavaScript enabled
    Given I am on the home page
    When I submit "String1" using "IndexButtonF"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"
      And the "Page1" parameter "index_field_8" should be "String1"
      And the "Page1" parameter "commit" should be "IndexButtonF"

  Scenario: Refresh all the page content using a form and first button with rails-ajax disabled with JavaScript disabled
    Given I am on the home page
    When I submit "String1" using "IndexButtonF"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"
      And the "Page1" parameter "index_field_8" should be "String1"
      And the "Page1" parameter "commit" should be "IndexButtonF"

  @javascript
  Scenario: Refresh just the page content using a form and second button with JavaScript enabled
    Given I am on the home page
    When I submit "String1" using "IndexButton2"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Page1" should be "1"
      And the "Page1" parameter "index_field_1" should be "String1"
      And the "Page1" parameter "commit" should be "IndexButton2"

  Scenario: Refresh just the page content using a form and second button with JavaScript disabled
    Given I am on the home page
    When I submit "String1" using "IndexButton2"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"
      And the "Page1" parameter "index_field_1" should be "String1"
      And the "Page1" parameter "commit" should be "IndexButton2"

  @javascript
  Scenario: Refresh just the page content using a form from a previous Ajax call and first button with JavaScript enabled
    Given I am on the home page
    When I submit "String1" using "IndexButton1"
      And I submit "String2" using "Page1Button1"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "2"
      And the "Index" parameter "page1_field_1" should be "String2"
      And the "Index" parameter "commit" should be "Page1Button1"

  Scenario: Refresh just the page content using a form from a previous Ajax call and first button with JavaScript disabled
    Given I am on the home page
    When I submit "String1" using "IndexButton1"
      And I submit "String2" using "Page1Button1"
    Then the refresh counter "Layout" should be "3"
      And the refresh counter "Index" should be "2"
      And the "Index" parameter "page1_field_1" should be "String2"
      And the "Index" parameter "commit" should be "Page1Button1"

  @javascript
  Scenario: Refresh just the page content using a form from a previous Ajax call and second button with JavaScript enabled
    Given I am on the home page
    When I submit "String1" using "IndexButton2"
      And I submit "String2" using "Page1Button2"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "2"
      And the "Index" parameter "page1_field_1" should be "String2"
      And the "Index" parameter "commit" should be "Page1Button2"

  Scenario: Refresh just the page content using a form from a previous Ajax call and second button with JavaScript disabled
    Given I am on the home page
    When I submit "String1" using "IndexButton2"
      And I submit "String2" using "Page1Button2"
    Then the refresh counter "Layout" should be "3"
      And the refresh counter "Index" should be "2"
      And the "Index" parameter "page1_field_1" should be "String2"
      And the "Index" parameter "commit" should be "Page1Button2"

  @javascript
  Scenario: Do not use Ajax when a target is specified in the form with JavaScript enabled
    Given I am on the home page
    When I submit "String1" in "targeted Text field" using "IndexButton3"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"
      And the "Page1" parameter "index_field_2" should be "String1"
      And the "Page1" parameter "commit" should be "IndexButton3"

  Scenario: Do not use Ajax when a target is specified in the form with JavaScript disabled
    Given I am on the home page
    When I submit "String1" in "targeted Text field" using "IndexButton3"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"
      And the "Page1" parameter "index_field_2" should be "String1"
      And the "Page1" parameter "commit" should be "IndexButton3"

  @javascript
  Scenario: Check that without scrolling, the bottom element is not visible using a form with JavaScript enabled
    Given I am on the home page
    When I submit "String1" in "Text field to page 3" using "IndexButton5"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "page_with_anchor" should be "1"
      And element "page_with_anchor_Bottom" should not be visible

  @javascript
  Scenario: Scroll the window to an anchor if needed with JavaScript enabled
    Given I am on the home page
    When I submit "String1" in "Text field to anchored page 3" using "IndexButton7"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "page_with_anchor" should be "1"
      And element "page_with_anchor_Bottom" should be visible

  @javascript @set_callbacks
  Scenario: Handle 404 error with content from a form with JavaScript enabled
    Given I am on the home page
    When I submit "String1" using "IndexButtonH"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Error404" should be "1"
      And the location URL should be "/error404"
      And the "beforeSend" callback should have been called
      And the "error" callback should have been called
      And the "complete" callback should have been called

  Scenario: Handle 404 error with content from a form with JavaScript disabled
    Given I am on the home page
    When I submit "String1" using "IndexButtonH"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Error404" should be "1"
      And the location URL should be "/error404"

  # TODO (capybara-webkit): Uncomment when webkit JS engine will not stop when back-end encounters a RoutingError
#  @javascript @set_callbacks @allow-rescue
#  Scenario: Handle Rails 404 error from a form with JavaScript enabled
#    Given I am on the home page
#    When I submit "String1" using "IndexButtonJ"
#    Then the refresh counter "Layout" should be "1"
#      And the refresh counter "Index" should be "1"
#      And the location URL should be "/incorrect_page"
#      And the "beforeSend" callback should have been called
#      And the "error" callback should have been called
#      And the "complete" callback should have been called
