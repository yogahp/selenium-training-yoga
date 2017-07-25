@javascript
Feature: 28 July 2017 
  
  Scenario: Maximizing Browser Window
    Given I go to home page
    When I try to maximizing browser window
    Then I should see my browser maximized
