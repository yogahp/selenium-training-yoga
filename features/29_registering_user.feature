@javascript
Feature: 4 August 2017 
  
  Scenario: Registering User 
    Given I've unverified random email
    When I try to verifying the email
    And I should get response the email is not present
    And I try to registering the email
    And I try to login using the email
    Then I should failed to login because i've not yet verified my account
