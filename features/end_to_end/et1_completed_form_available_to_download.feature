@e2e
@javascript @smoke
Feature:
  As an admin
  I want to be able to download completed Employment Tribunal forms
  I want to ensure that all files get exported to CCD
  So I can triage an employees claim against their employer
  
  Scenario: Checking for claim presence.
    Given an employee making a claim
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: No representative
    Given an employee making a claim without a representative
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: 2 people making a claim
    Given '2' employees making a claim
    When the completed form is submitted
    Then the multiple claimants should be present in CCD

  Scenario: Respondent details - 3 Respondents
    Given an employee making a claim against '3' respondents
    When the completed form is submitted
    Then the claim should be present in CCD

  Scenario: Validate TXT file when uploading CSV data
    Given 7 employees making a claim by uploading CSV file
    When the completed form is submitted
    Then the multiple claimants should be present in CCD

  Scenario: Validate CSV file when uploading CSV data
    Given 7 employees making a claim by uploading CSV file
    When the completed form is submitted
    Then the multiple claimants should be present in CCD

  Scenario: Making claim against 3 employers
    Given an employee making a claim against 3 employers
    When the completed form is submitted
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

  Scenario: Claimant's rtf file is converted to a pdf in CCD
    Given an employee making a claim by uploading a Rich Text Format document
    When the completed form is submitted
    Then the PDF file should be present in CCD
    And the PDF is converted correctly
