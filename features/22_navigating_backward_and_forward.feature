@javascript
Feature: 28 July 2017 
  
  Scenario: Navigating Backward and Forward 
    Given I go to home page
    When I click "Login" link
    And I try to go back to homepage
    Then I should see homepage
    And I try to go forward to login page
    Then I should see login page
