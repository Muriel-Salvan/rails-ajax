Feature: Devise
  Devise controllers work correctly with rails-ajax

  @javascript
  Scenario: Sign up link works with JavaScript enabled
    Given I am on the home page
    When I click on "Sign up" from "Layout"
    Then the refresh counter "SignUp" should be "1"
      And the location URL should be "/users/sign_up"
      And the refresh counter "Layout" should be "1"

  Scenario: Sign up link works with JavaScript disabled
    Given I am on the home page
    When I click on "Sign up" from "Layout"
    Then the refresh counter "SignUp" should be "1"
      And the location URL should be "/users/sign_up"
      And the refresh counter "Layout" should be "2"

  @javascript
  Scenario: User creation works with JavaScript enabled
    Given I register user "test@x-aeon.com" with password "testtest"
    Then the refresh counter "Index" should be "1"
      And the location URL should be "/"
      And the refresh counter "Layout" should be "1"
      And user "test@x-aeon.com" should be registered
      And the flash message "Notice" should be "Welcome! You have signed up successfully."

  Scenario: User creation works with JavaScript disabled
    Given I register user "test@x-aeon.com" with password "testtest"
    Then the refresh counter "Index" should be "1"
      And the location URL should be "/"
      And the refresh counter "Layout" should be "2"
      And user "test@x-aeon.com" should be registered
      And the flash message "Notice" should be "Welcome! You have signed up successfully."

  @javascript
  Scenario: User creation with unmatched passwords works with JavaScript enabled
    Given I register user "test@x-aeon.com" with unmatched passwords "testtest" and confirmation "wrongpassword"
    Then the refresh counter "SignUp" should be "2"
      And the location URL should be "/users"
      And the refresh counter "Layout" should be "1"
      And user "test@x-aeon.com" should not be registered
      And the mismatched passwords error should be displayed

  Scenario: User creation with unmatched passwords works with JavaScript disabled
    Given I register user "test@x-aeon.com" with unmatched passwords "testtest" and confirmation "wrongpassword"
    Then the refresh counter "SignUp" should be "2"
      And the location URL should be "/users"
      And the refresh counter "Layout" should be "2"
      And user "test@x-aeon.com" should not be registered
      And the mismatched passwords error should be displayed
