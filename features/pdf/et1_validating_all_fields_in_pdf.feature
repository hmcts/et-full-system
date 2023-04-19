@e2e
@javascript
Feature:
  As a CCD
  I want to ensure that all fields are mapped correctly in CCD
  So civil servant can triage an employees claim against their employer

  Scenario: Your details - contact by post
    Given an employee making a claim wanting to be contacted by 'post'
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Your details - contact by email
    Given an employee making a claim wanting to be contacted by 'email'
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Respondent details - Another person has the Acas number
    Given an employee making a claim with joint claim ACAS number
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Respondent details - Acas doesnt have the power
    Given an employee making a claim with no jurisdiction
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Respondent details - Employer already been in touch
    Given an employee making a claim with employer contacted ACAS
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Respondent details - Unfair dismissal
    Given an employee making a claim with interim relief
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Not aware of multiple cases against the same employer
    Given an employee making a claim against an employer not aware of multiple cases against the same employer
    When the completed form is submitted
    Then the claim should be present in CCD

   Scenario: Cases where the respondent was not your employer
     Given an employee making a claim against a trade union
     When the completed form is submitted
     Then the claim should be present in CCD

  Scenario: Employment details - No never employed
    Given an employee making a claim against an employer who never worked for them
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Employment details - working a notice period for this employer
    Given an employee making a claim against an employer who is working against their notice period
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Employment details - no longer working for this employer
    Given an employee making a claim against an employer who is no longer working for them
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Employment details - no did not work (or get paid for) a period of notice?
    Given an employee making a claim against an employer who no longer work for them
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Employment details - no not aware of employer's pension scheme?
    Given an employee making a claim against an employer who is not aware of pension scheme
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: About the claim - no to Are you reporting suspected wrongdoing at work?
    Given an employee making a claim against an employer who doesn't suspect any wrongdoing at work
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Claim details - no to Multiple cases
    Given an employee making a unique claims
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Claim outcome - leaving all fields blank
    Given an employee making a claim without wanting any claims outcome
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: More about the claim - no to provide additional information
    Given an employee making a claim without providing anymore information
    When the completed form is submitted
    Then the claim should be present in CCD