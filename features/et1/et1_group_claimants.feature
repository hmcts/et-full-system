@e2e
@javascript
Feature:
  As Group claims page
  I want to ensure that user can submit their Group claims in Welsh or in English

  Background: Group claims page
    Given a claimant is on Group claims page 

  Scenario: Verify copy texts
    Then Group claims page copy texts are displayed in the correct language

  Scenario: Single claimant
    When I submit no other people are making claims
    Then I should be on the Respresentative's details page

  Scenario: Verify copy texts for 5 or few claimants
    When there 5 or few claimants
    Then I can very that the copy texts correctly dispayed for group claimants

  Scenario: Two Claimants
    Given two employees making a claim
    Then I should be able to submit two claimants details
    
  Scenario: Verify copy texts for Upload user details in separate spreadsheet
    When there are group claimants
    Then I can very that the copy texts correctly dispayed for Upload user details in separate spreadsheet

  # Scenario: Download spreadsheet template
  #   When I'm on Spreadsheet for group claim
  #   Then I should be able to download spreadsheet template

  # Scenario: Submit group claims via separate spreadsheet
  #   Then I should be able to upload and submit a group claims via separate spreadsheet