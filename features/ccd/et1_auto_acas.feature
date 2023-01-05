@e2e
@javascript
@acas
Feature:
  As a CCD
  I want to ensure that all fields are mapped correctly in CCD
  So civil servant can triage an employees claim against their employer

  Scenario: A claim with a valid acas certificate attaches the certificate to the claim
    Given an employee making a claim wanting to be contacted by 'post'
    When the completed form is submitted
    Then the claim should be present in CCD with an attached acas certificate

  Scenario: A claim with an invalid acas certificate still sends the claim without a certificate
    Given an employee making a claim with an invalid acas certificate wanting to be contacted by 'post'
    When the completed form is submitted
    Then the claim should be present in CCD with no attached acas certificate
