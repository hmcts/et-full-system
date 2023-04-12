@e2e
@javascript
Feature:
  As a CCD
  I want to ensure that all files are sent correctly to CCD

  Scenario: Make a basic response to an existing claim
    Given an employer responds to an existing claim
    When the completed Employment Tribunal response form is submitted
    And the submitted Employment Tribunal response is exported to ccd for me
    Then the response files should be present in the existing ccd claim
  Scenario:  Make a basic response to a new claim
    Given an employer responds to an existing external reformed case for england and wales Bristol office
    When the completed Employment Tribunal response form is submitted
    And the submitted Employment Tribunal response is exported to ccd for me
    Then the response should have been moved to the Bristol office
