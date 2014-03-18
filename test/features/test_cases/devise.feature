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
      And user "test@x-aeon.com" should be registered and signed in
      And the flash message "Notice" should be "Welcome! You have signed up successfully."

  Scenario: User creation works with JavaScript disabled
    Given I register user "test@x-aeon.com" with password "testtest"
    Then the refresh counter "Index" should be "1"
      And the location URL should be "/"
      And the refresh counter "Layout" should be "2"
      And user "test@x-aeon.com" should be registered and signed in
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

  @javascript
  Scenario: Sign in link works with JavaScript enabled
    Given I am on the home page
    When I click on "Sign in" from "Layout"
    Then the refresh counter "SignIn" should be "1"
      And the location URL should be "/users/sign_in"
      And the refresh counter "Layout" should be "1"

  Scenario: Sign in link works with JavaScript disabled
    Given I am on the home page
    When I click on "Sign in" from "Layout"
    Then the refresh counter "SignIn" should be "1"
      And the location URL should be "/users/sign_in"
      And the refresh counter "Layout" should be "2"

  @javascript @set_callbacks
  Scenario: User signs in with JavaScript enabled
    Given I am on the home page
      And user "test@x-aeon.com" is registered with password "testtest"
    When I click on "Sign in" from "Layout"
      And I sign in user "test@x-aeon.com" with password "testtest"
    Then the refresh counter "Index" should be "2"
      And the location URL should be "/"
      And the refresh counter "Layout" should be "1"
      And user "test@x-aeon.com" should be registered and signed in
      And the flash message "Notice" should be "Signed in successfully."
      # GET /users/sign_in
      And the "beforeSend" callback should have been called
      And the "success" callback should have been called
      And the "complete" callback should have been called
      # POST /users/sign_in
      And the "beforeSend" callback should have been called
      And the "success" callback should have been called
      And the "complete" callback should have been called
      # GET / (redirect)
      And the "success" callback should have been called
      And the "complete" callback should have been called

  Scenario: User signs in with JavaScript disabled
    Given I am on the home page
      And user "test@x-aeon.com" is registered with password "testtest"
    When I click on "Sign in" from "Layout"
      And I sign in user "test@x-aeon.com" with password "testtest"
    Then the refresh counter "Index" should be "2"
      And the location URL should be "/"
      And the refresh counter "Layout" should be "3"
      And user "test@x-aeon.com" should be registered and signed in
      And the flash message "Notice" should be "Signed in successfully."

  @javascript @set_callbacks
  Scenario: User signs in with wrong password with JavaScript enabled
    Given I am on the home page
      And user "test@x-aeon.com" is registered with password "testtest"
    When I click on "Sign in" from "Layout"
      And I sign in user "test@x-aeon.com" with password "badpassword"
      And I wait for "6" callbacks to be triggered
    Then the refresh counter "SignIn" should be "1"
      And the location URL should be "/users/sign_in"
      And the refresh counter "Layout" should be "1"
      And nobody should be signed in
      # GET /users/sign_in
      And the "beforeSend" callback should have been called
      And the "success" callback should have been called
      And the "complete" callback should have been called
      # POST /users/sign_in
      And the "beforeSend" callback should have been called
      And the "error" callback should have been called
      And the "complete" callback should have been called

  Scenario: User signs in with wrong password with JavaScript disabled
    Given I am on the home page
      And user "test@x-aeon.com" is registered with password "testtest"
    When I click on "Sign in" from "Layout"
      And I sign in user "test@x-aeon.com" with password "badpassword"
    Then the refresh counter "SignIn" should be "2"
      And the location URL should be "/users/sign_in"
      And the refresh counter "Layout" should be "3"
      And nobody should be signed in

  @javascript @set_callbacks
  Scenario: User signs out with JavaScript enabled
    Given I am on the home page
      And user "test@x-aeon.com" is registered with password "testtest"
      And user is signed in
    When user signs out
    Then the refresh counter "Index" should be "2"
      And the location URL should be "/"
      And the refresh counter "Layout" should be "1"
      And nobody should be signed in
      # POST /users/sign_out
      And the "beforeSend" callback should have been called
      And the "success" callback should have been called
      And the "complete" callback should have been called
      # GET / (redirect)
      And the "success" callback should have been called
      And the "complete" callback should have been called
      And the flash message "Notice" should be "Signed out successfully."

  Scenario: User signs out with JavaScript disabled
    Given I am on the home page
      And user "test@x-aeon.com" is registered with password "testtest"
      And user is signed in
    When user signs out
    Then the refresh counter "Index" should be "2"
      And the location URL should be "/"
      And the refresh counter "Layout" should be "2"
      And nobody should be signed in
      And the flash message "Notice" should be "Signed out successfully."

  @javascript @set_callbacks
  Scenario: Unsigned user signs out with JavaScript enabled
    Given I am on the home page
    When user signs out
    Then the refresh counter "Index" should be "2"
      And the location URL should be "/"
      And the refresh counter "Layout" should be "1"
      And nobody should be signed in
      # POST /users/sign_out
      And the "beforeSend" callback should have been called
      And the "success" callback should have been called
      And the "complete" callback should have been called
      # GET / (redirect)
      And the "success" callback should have been called
      And the "complete" callback should have been called

  Scenario: Unsigned user signs out with JavaScript disabled
    Given I am on the home page
    When user signs out
    Then the refresh counter "Index" should be "2"
      And the location URL should be "/"
      And the refresh counter "Layout" should be "2"
      And nobody should be signed in
