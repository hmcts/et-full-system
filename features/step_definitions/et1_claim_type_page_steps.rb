Given("a claimant is on About the claim page") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent, 1, :no_acas, :both_addresses, :yes_acas)
  @employment = FactoryBot.create(:employment)
  start_a_new_et1_claim
  et1_answer_login
  et1_answer_claimant_questions
  et1_answer_group_claimants_questions
  et1_answer_representatives_questions
  et1_answer_respondents_questions
  et1_answer_employment_details_questions
end

Then("I can verify that the copy text on About the claim page displayed correctly") do
  et1_claim_type_page.unfair_dismissal.hint.click
  et1_claim_type_page.other_type_of_claim.set(:is_other_type_of_claim)
  et1_claim_type_page.whistleblowing_claim.is_whistleblowing.set(:yes)
  expect(et1_claim_type_page.has_correct_translation?).to be true
end

Then("I select all claim types") do
  claim = FactoryBot.create(:claim)
  et1_claim_type_page.set(claim)
end

Then("I should be on Claim details page") do
  et1_claim_type_page.save_and_continue
  expect(et1_claim_details_page).to have_page_header
end

Then("I submit without selecting a claim type") do
  et1_claim_type_page.save_and_continue
end

Then("I an error message displaying claim types must be selected") do
  expect(et1_claim_type_page.has_missing_claim_type_error_message?).to be true
end
