Feature: Configuration
  Test all configuration options

  @javascript
  Scenario: Change flash containers
    Given I am on the home page
      And I setup flash container "notice" to "FlashNewNotice"
      And I setup flash container "error" to "FlashNewError"
      And I setup flash container "alert" to "FlashNewAlert"
    When I click on "page_with_flash" from "Index"
    Then the refresh counter "page_with_flash" should be "1"
      And the flash message "Notice" should be ""
      And the flash message "Alert" should be ""
      And the flash message "Error" should be ""
      And the flash message "NewNotice" should be "Flash notice"
      And the flash message "NewAlert" should be "Flash alert"
      And the flash message "NewError" should be "Flash error"

  @javascript
  Scenario: Change the default main container
    Given I am on the home page
      And I setup the main container to "NewContent"
    When I click on "Page1" from "Index"
    Then the refresh counter "Page1" should be "1"
      And the refresh counter "Index" should be "2"
      And the element "#Page1" should be inside element "#NewContent"
      And the element "#Index" should be inside element "#Content"
