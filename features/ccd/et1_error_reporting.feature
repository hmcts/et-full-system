@e2e
@javascript
Feature:
  As a CCD administrator
  I want to ensure that I am aware of temporary and permanent problems in the transmission
  of data to CCD

  @local
  Scenario: Submitting a claim which will cause an error which the system will not recover from but admin user views before failure
    Given a claimant submitting data to trigger a 422 error using fake ccd
    When the completed form is submitted
    Then the claim in the admin should show that the export to CCD is erroring
    And the claim in the admin should show that the export to CCD is erroring for the right reason

  @local
  Scenario: Submitting a claim where one of the secondary claimants will cause an error 502 for the first time which the system will recover from
    Given a claimant submitting data to trigger a 502 error once only in a secondary claimant using fake ccd
    When the completed form is submitted
    Then the claim in the admin should show that the export sent to CCD

  Scenario: Submitting a claim that goes through to the admin
    Given a claimant submitting mandatory Claimant's Details fields
    When the completed form is submitted
    Then the claim in the admin should show that the export sent to CCD
