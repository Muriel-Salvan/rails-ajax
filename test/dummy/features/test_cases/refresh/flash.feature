Feature: Refresh flash messages
  Flash messages are refreshed when needed

  @javascript
  Scenario: Refresh flash messages with JavaScript enabled
    Given I am on the home page
    When I click on "page_with_flash" from "Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "page_with_flash" should be "1"
      And the flash message "Notice" should be "Flash notice"
      And the flash message "Alert" should be "Flash alert"
      And the flash message "Error" should be "Flash error"

  Scenario: Refresh flash messages with JavaScript disabled
    Given I am on the home page
    When I click on "page_with_flash" from "Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "page_with_flash" should be "1"
      And the flash message "Notice" should be "Flash notice"
      And the flash message "Alert" should be "Flash alert"
      And the flash message "Error" should be "Flash error"

  @javascript
  Scenario: Empty flash messages with JavaScript enabled
    Given I am on the home page
    When I click on "page_with_flash" from "Index"
      And I click on "Index" from "page_with_flash"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "2"
      And the flash message "Notice" should be ""
      And the flash message "Alert" should be ""
      And the flash message "Error" should be ""

  Scenario: Empty flash messages with JavaScript disabled
    Given I am on the home page
    When I click on "page_with_flash" from "Index"
      And I click on "Index" from "page_with_flash"
    Then the refresh counter "Layout" should be "3"
      And the refresh counter "Index" should be "2"
      And the flash message "Notice" should be ""
      And the flash message "Alert" should be ""
      And the flash message "Error" should be ""

  @javascript
  Scenario: Simple redirect with flash updates with JavaScript enabled
    Given I am on the home page
    When I click on "Redirect" from "flashed Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Page1" should be "1"
      And the location URL should be "/page1"
      And the flash message "Notice" should be "Flash notice"
      And the flash message "Alert" should be "Flash alert"
      And the flash message "Error" should be "Flash error"

  Scenario: Simple redirect with flash updates with JavaScript disabled
    Given I am on the home page
    When I click on "Redirect" from "flashed Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"
      And the location URL should be "/page1"
      And the flash message "Notice" should be "Flash notice"
      And the flash message "Alert" should be "Flash alert"
      And the flash message "Error" should be "Flash error"

  @javascript
  Scenario: Simple redirect with flash updates then deletion with JavaScript enabled
    Given I am on the home page
    When I click on "Redirect" from "flashed Index"
      And I click on "Page2" from "Page1"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Page2" should be "1"
      And the location URL should be "/page2"
      And the flash message "Notice" should be ""
      And the flash message "Alert" should be ""
      And the flash message "Error" should be ""

  Scenario: Simple redirect with flash updates then deletion with JavaScript disabled
    Given I am on the home page
    When I click on "Redirect" from "flashed Index"
      And I click on "Page2" from "Page1"
    Then the refresh counter "Layout" should be "3"
      And the refresh counter "Page2" should be "1"
      And the location URL should be "/page2"
      And the flash message "Notice" should be ""
      And the flash message "Alert" should be ""
      And the flash message "Error" should be ""

  @javascript
  Scenario: Refresh flash messages using forms with JavaScript enabled
    Given I am on the home page
    When I submit "String1" in "Text field to page 8" using "IndexButtonB"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "page_with_flash" should be "1"
      And the flash message "Notice" should be "Flash notice"
      And the flash message "Alert" should be "Flash alert"
      And the flash message "Error" should be "Flash error"

  Scenario: Refresh flash messages using forms with JavaScript disabled
    Given I am on the home page
    When I submit "String1" in "Text field to page 8" using "IndexButtonB"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "page_with_flash" should be "1"
      And the flash message "Notice" should be "Flash notice"
      And the flash message "Alert" should be "Flash alert"
      And the flash message "Error" should be "Flash error"

  @javascript
  Scenario: Empty flash messages using forms with JavaScript enabled
    Given I am on the home page
    When I submit "String1" in "Text field to page 8" using "IndexButtonB"
      And I submit "String2" using "page_with_flash_Button1"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "2"
      And the flash message "Notice" should be ""
      And the flash message "Alert" should be ""
      And the flash message "Error" should be ""

  Scenario: Empty flash messages using forms with JavaScript disabled
    Given I am on the home page
    When I submit "String1" in "Text field to page 8" using "IndexButtonB"
      And I submit "String2" using "page_with_flash_Button1"
    Then the refresh counter "Layout" should be "3"
      And the refresh counter "Index" should be "2"
      And the flash message "Notice" should be ""
      And the flash message "Alert" should be ""
      And the flash message "Error" should be ""

  @javascript
  Scenario: Simple redirect with flash updates using forms with JavaScript enabled
    Given I am on the home page
    When I submit "String1" in "Text field to flashed redirect" using "IndexButtonD"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Page1" should be "1"
      And the location URL should be "/page1"
      And the flash message "Notice" should be "Flash notice"
      And the flash message "Alert" should be "Flash alert"
      And the flash message "Error" should be "Flash error"

  Scenario: Simple redirect with flash updates using forms with JavaScript disabled
    Given I am on the home page
    When I submit "String1" in "Text field to flashed redirect" using "IndexButtonD"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "Page1" should be "1"
      And the location URL should be "/page1"
      And the flash message "Notice" should be "Flash notice"
      And the flash message "Alert" should be "Flash alert"
      And the flash message "Error" should be "Flash error"

  @javascript
  Scenario: Simple redirect with flash updates then deletion using forms with JavaScript enabled
    Given I am on the home page
    When I submit "String1" in "Text field to flashed redirect" using "IndexButtonD"
      And I submit "String2" using "Page1Button1"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "2"
      And the location URL should be "/"
      And the flash message "Notice" should be ""
      And the flash message "Alert" should be ""
      And the flash message "Error" should be ""

  Scenario: Simple redirect with flash updates then deletion using forms with JavaScript disabled
    Given I am on the home page
    When I submit "String1" in "Text field to flashed redirect" using "IndexButtonD"
      And I submit "String2" using "Page1Button1"
    Then the refresh counter "Layout" should be "3"
      And the refresh counter "Index" should be "2"
      And the location URL should be "/"
      And the flash message "Notice" should be ""
      And the flash message "Alert" should be ""
      And the flash message "Error" should be ""
