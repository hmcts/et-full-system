@et3 @javascript

Feature: Checking the responses page in the admin

  Background: ET3 responses admin page
    Given an administrator login
    And selected responses section of the admin

  Scenario: View the responses admin interface
    Then I should see the ET3 responses page

    Scenario: Editing the default office
      When I select the edit button for the first row and change the office
      Then I should see the updated office in the responses page