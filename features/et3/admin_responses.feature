@et3 @javascript

Feature: Checking the responses page in the admin

  Background: ET3 responses admin page
    Given an administrator login
    And selected responses section of the admin

  Scenario: View the admin interface
    Then I should see the ET3 responses page