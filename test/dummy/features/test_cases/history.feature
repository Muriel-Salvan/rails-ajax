Feature: History
  Browser keeps history when following Ajax links

  @javascript
  Scenario: Browser's history remembers last page with JavaScript enabled
    Given I am on the home page
    When I click on "Page1" from "Index"
      And I go back "1" times in history
    Then the location URL should be "/"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "2"

  @javascript
  Scenario: Browser's history remembers 2 last pages with JavaScript enabled
    Given I am on the home page
    When I click on "Page1" from "Index"
      And I click on "Page2" from "Page1"
      And I click on "page_with_anchor" from "Page2"
      And I go back "2" times in history
    Then the location URL should be "/page1"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Page1" should be "2"

  @javascript
  Scenario: Browser's history remembers last page from a form with JavaScript enabled
    Given I am on the home page
    When I submit "String1" using "IndexButton1"
      And I go back "1" times in history
    Then the location URL should be "/"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "2"

  @javascript
  Scenario: Browser's history remembers 2 last pages from forms with JavaScript enabled
    Given I am on the home page
    When I submit "String1" using "IndexButton1"
      And I submit "String2" in "Text field to page 2" using "Page1Button3"
      And I submit "String3" using "Page2Button1"
      And I go back "2" times in history
    Then the location URL should be "/page1"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "Page1" should be "2"
      And the "Page1" parameter "index_field_1" should be "String1"
      And the "Page1" parameter "commit" should be "IndexButton1"

  @javascript
  Scenario: Check that anchor is not visible when not scrolled with JavaScript enabled
    Given I am on the home page
    When I click on "page_with_anchor" from "Index"
      And I click on "Index" from "page_with_anchor"
      And I go back "1" times in history
    Then the location URL should be "/page_with_anchor"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "page_with_anchor" should be "2"
      And element "page_with_anchor_Bottom" should not be visible

  @javascript
  Scenario: Browser's history remembers anchors with JavaScript enabled
    Given I am on the home page
    When I click on "page_with_anchor" from "Index with anchor"
      And I click on "Index" from "page_with_anchor"
      And I go back "1" times in history
    # TODO (History.js): When History.js will handle correctly anchors, the location should be "/page_with_anchor#Anchor"
    Then the location URL should be "/page_with_anchor"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "page_with_anchor" should be "2"
      And element "page_with_anchor_Bottom" should be visible

  @javascript
  Scenario: Browser's history remembers anchors used with forms with JavaScript enabled
    Given I am on the home page
    When I submit "String1" in "Text field to page 3 with anchor" using "IndexButton7"
      And I click on "Index" from "page_with_anchor"
      And I go back "1" times in history
    # TODO (History.js): When History.js will handle correctly anchors, the location should be "/page_with_anchor#Anchor"
    Then the location URL should be "/page_with_anchor"
      And the refresh counter "Layout" should be "1"
      And the refresh counter "page_with_anchor" should be "2"
      And element "page_with_anchor_Bottom" should be visible
      And the "page_with_anchor" parameter "index_field_4" should be "String1"
      And the "page_with_anchor" parameter "commit" should be "IndexButton7"

  @javascript
  Scenario: Browser's history remembers redirects with JavaScript enabled
    Given I am on the home page
    When I click on "Redirect" from "Index"
      And I wait for "Page1"
      And I go back "1" times in history
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "Index" should be "2"
      And the location URL should be "/"
