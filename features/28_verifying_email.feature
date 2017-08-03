@javascript
Feature: 4 August 2017 
  
  Scenario: Verifying Email
    Given I've unverified email
    When I try to verifying the email
    Then I should get response the email is not present
