@javascript
Feature: 28 July 2017 
  
  Scenario Outline: Switching to an iframe 
    Given I go to switching an iframe page 
    When I switch to iframe <iFrame Name> 
    Then I should see iframe <iFrame Content>

    Examples:
      | iFrame Name          | iFrame Content                      |
      | "Moka Blog"          | "A CUP OF MOKA"                     |
      | "Muslim Pro"         | "Prayer times and Qibla direction"  |
