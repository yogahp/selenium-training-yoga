@javascript
Feature: 28 July 2017 
  
  Scenario Outline: Switching to HTML frame 
    Given I go to switching to html frame page
    When I switch to <Frame Name> 
    Then I should see <Frame Name> content

    Examples:
      | Frame Name            |
      | "Frame A"             |
      | "Frame B"             |
      | "Frame C"             |
