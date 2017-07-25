@javascript
Feature: 28 July 2017 
  
  Scenario: Handling session cookies 
    Given I go to home page
    When I click "Login" link
    And I fill in "user[email]" field with "test@mokapos.com"
    And I fill in "user[password]" field with "123456"
    And I click "Sign In" button
    Then I should have cookie named "remember_token" 
