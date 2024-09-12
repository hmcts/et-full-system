@e2e
@javascript
@smoke
Feature: ET3 response to local office
  As an admin
  I want to be able to check data in the admin json.

  Scenario: View a file claim in the admin interface
    Given an employer responds to a claim
    When the completed Employment Tribunal response form is submitted
    Then the response should be viewable in the admin

  Scenario: View a file claim in the admin interface json
    Given an employer responds to a claim
    When the completed Employment Tribunal response form is submitted
    Then the response should be viewable in the admin json
  
   Scenario: No representative
    Given an employer responds to a claim with no respresentative
    When the completed Employment Tribunal response form is submitted
    Then the response should be viewable in the admin json

  Scenario: Employment dates
    Given an employer respond yes to 'Are the dates of employment given by the claimant correct'
    When the completed Employment Tribunal response form is submitted
    Then the response should be viewable in the admin json

  Scenario: Case number starting with 13 will be forwarded to Midlands (West)
    Given an employer responds to a claim with case number starting '1354321/2017'
    When the completed Employment Tribunal response form is submitted
    Then it will have the correct submission date
    Then the response should be viewable in the admin json

  Scenario: Case number starting with 99 will be forwarded to the Default Office
    Given an employer responds to a claim with case number starting '9954321/2017'
    When the completed Employment Tribunal response form is submitted
    Then it will have the correct submission date
    And the response should be viewable in the admin json

  Scenario: Respondent answers to mandatory questions
    When an employer responds to mandatory questions
    Then the minimal response should be viewable in the admin json

  Scenario: Ignore special characters in Company's name
    When an employer responds to a claim with special characters in the company's name
    Then the minimal response should be viewable in the admin json
