@e2e
@javascript
Feature:
  As a CCD
  I want to ensure that all fields are mapped correctly in CCD
  So civil servant can triage an employees claim against their employer

  Scenario: Your details - title Ms, Gender prefer not to say, contact by post
    Given an employee making a claim wanting to be contacted by 'post'
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Your details - contact by email
    Given an employee making a claim wanting to be contacted by 'email'
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Your details - title Mr, Gender Male
    Given a Male employee making a claim
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Your details - title Mrs, Gender Female
    Given a married woman employee making a claim
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Your details - title Miss, Gender Female
    Given a female employee making a claim
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: claimaint's address is outside UK
    Given a claimant submitted an ET1 who live outside UK
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: claimaint does not require assistance at the tribunal hearing
    Given a claimant who does not require assistance at the tribunal hearing submitted an ET1 online
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Submitting mandatory Claimant's Details fields
    Given a claimant submitting mandatory Claimant's Details fields
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: No representative
    Given an employee making a claim without a respresentative
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Submitting mandatory representative fields
    Given an employee submitting mandatory respresentative fields
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

  Scenario: Respondent details - Don't have acas number - Another person has the Acas number
    Given an employee making a claim with joint claim acas number
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Respondent details - Don't have acas number -  Acas doesnt have the power
    Given an employee making a claim with no jurisdiction
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Respondent details - Don't have acas number -  Employer already been in touch
    Given an employee making a claim with employer contacted acas
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Respondent details - Don't have acas number -  Unfair dismissal
    Given an employee making a claim with interim relief
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Multiple additional respondents
    Given an employee making a claim against 5 employers
    When the completed form is submitted
    Then the claim should be present in CCD
    And the CCD claim should have 5 acas certificates

  Scenario: Respondent details - same address as to the one given above
    Given an employee making a claim where the respondent provided the same address
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Additional respondents - with acas number
    Given an employee making a claim where the additional respondents provided an acas number
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Additional respondents - I don\'t have an Acas number
    Given an employee making a claim where the additional respondents gave reason for not having an acas number
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Submitting mandatory respondent's Details fields
    Given a claimant submitting mandatory respondent's Details fields
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Single claimaint - RTF format
    Given an employee making a claim by uploading a Rich Text Format document
    When the completed form is submitted
    Then the RTF file should be present in CCD

  Scenario: Multiple claimaints - RTF, PDF and CSV format
    Given an employee submitting an ET1 form by uploading CSV and RTF documents
    When the completed form is submitted
    Then the multiple claimants should be present in CCD

  Scenario: Multiple claimants - RTF format
    Given an multiple claimants making a claim by uploading a Rich Text Format document
    When the completed form is submitted
    Then the multiple claimants should be present in CCD

  Scenario: Multiple claimants - manually entering 3 claimaint's details
    Given '3' employees making a claim
    When the completed form is submitted
    Then the multiple claimants should be present in CCD

  Scenario: Multiple claimants - uploading multiple claimants using CSV file
    Given 7 employees making a claim by uploading CSV file
    When the completed form is submitted
    Then the multiple claimants should be present in CCD

  Scenario: Multiple claimants and multiple respondents
    Given '3' employees making a claim with multiple respondents
    When the completed form is submitted
    Then the multiple claimants should be present in CCD

  Scenario: A claim for the default office should go wherever the administrator wants
    Given a claimant submitted an ET1 with a work post code of "Z1 2LL"
    When the completed form is submitted
    And the administrator exports the claim to the scotland office
    Then the claim should be present in the "41" office CCD system