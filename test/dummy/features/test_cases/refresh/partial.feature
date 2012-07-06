Feature: Refresh partials
  Pages can also refresh parts of the layout (or any part) specifically

  @javascript
  Scenario: Refresh just the second div along with page 4 using refresh_dom_with_partial with JavaScript enabled
    Given I am on the home page
    When I click on "page_with_refresh_layoutdiv" from "Index"
    Then the refresh counter "Layout" should be "1"
      And the refresh counter "page_with_refresh_layoutdiv" should be "1"
      And the refresh counter "LayoutDiv1" should be "1"
      And the refresh counter "LayoutDiv2" should be "2"

  Scenario: Refresh just the second div along with page 4 using refresh_dom_with_partial with JavaScript disabled
    Given I am on the home page
    When I click on "page_with_refresh_layoutdiv" from "Index"
    Then the refresh counter "Layout" should be "2"
      And the refresh counter "page_with_refresh_layoutdiv" should be "1"
      And the refresh counter "LayoutDiv1" should be "2"
      And the refresh counter "LayoutDiv2" should be "2"
