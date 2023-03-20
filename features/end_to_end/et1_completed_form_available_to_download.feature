@e2e
@javascript @smoke
Feature:
  As an ATOS admin
  I want to be able to download completed Employment Tribunal forms
  I want to ensure that all files get exported to CCD
  So I can triage an employees claim against their employer
  
  Scenario: PDF format
    Given an employee making a claim
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: TXT format
    Given an employee making a claim
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: RTF format
    Given an employee making a claim by uploading a Rich Text Format document
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: No representative
    Given an employee making a claim without a respresentative
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: 2 people making a claim
    Given '2' employees making a claim
    When the completed form is submitted
    Then the multiple claimaints should be present in CCD

  Scenario: Respondent details - 3 Respondents
    Given an employee making a claim against '3' respondents
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Validate TXT file when uploading CSV data
    Given 7 employees making a claim by uploading CSV file
    When the completed form is submitted
    Then the multiple claimaints should be present in CCD

  Scenario: Validate CSV file when uploading CSV data
    Given 7 employees making a claim by uploading CSV file
    When the completed form is submitted
    Then the multiple claimaints should be present in CCD

  Scenario: Making claim against 3 employers
    Given an employee making a claim against 3 employers
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Ignore special characters in first and last name when generating filenames
    When a claimant submitted an ET1 with special characters in the first and last name 
    Then the claim should be present in CCD

  Scenario: No employment details
    Given a claimant submitted an ET1 with no employment details
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: claimant's address is outside UK
    Given a claimant submitted an ET1 who live outside UK
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Claimant home postcode G1 1BL will be forwarded to Glasgow office
    Given claimant home postcode 'G1 1BL' then submission office will be '41'
    When the completed form is submitted 
    Then the claim should be present in CCD

  Scenario: Claimant's work address is unknown
    Given claimant work postcode 'Z1 2LL' then submission office will be '99'
    When the completed form is submitted
    Then I can verify the claim has correct office code and reference
