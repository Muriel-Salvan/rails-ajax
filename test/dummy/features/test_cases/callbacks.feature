Feature: Callbacks
  When pages are refreshed using RailsAjax, user callbacks are called

  @javascript @set_callbacks
  Scenario: Callbacks called correctly in case of success with JavaScript enabled
    Given I am on the home page
    When I click on "Page1" from "Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Page1" should be "1"
      And the location URL should be "/page1"
      And the "beforeSend" callback should have been called
      And the "success" callback should have been called
      And the "complete" callback should have been called

# TODO: Uncomment when Cucumber will correctly reset Rails environment: it will not make subsequent tests fail
#  @javascript @set_callbacks
#  Scenario: Callbacks called correctly in case of failure with JavaScript enabled
#    Given I am on the home page
#    When I click on "IncorrectPage" from "Index"
#    Then the refresh counter "Layout" should be "1"
#      And the refresh counter "Index" should be "1"
#      And the location URL should be "/incorrect_page"
#      And the "beforeSend" callback should have been called
#      And the "error" callback should have been called
#      And the "complete" callback should have been called

  @javascript @set_callbacks
  Scenario: Callbacks called correctly in case of a cancel during beforeSend with JavaScript enabled
    Given I am on the home page
      And I mark the next Ajax call to be cancelled
    When I click on "Page1" from "Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "1"
      And the location URL should be "/"
      And the "beforeSend" callback should have been called
