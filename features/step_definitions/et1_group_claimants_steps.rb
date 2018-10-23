Given("a claimant is on Group claims page") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  start_a_new_et1_claim
  et1_answer_login
  et1_answer_claimant_questions
end

Then("Group claims page copy texts are displayed in the correct language") do
  expect(et1_group_claimants_page.has_correct_translation_on_group_claims?).to be true
end

When("I submit no other people are making claims") do
  et1_group_claimants_page.set(@claimant)
  et1_group_claimants_page.save_and_continue
end

Then("I should be on the Respresentative's details page") do
  expect(et1_representatives_details_page.main_header).to have_page_header
end

When("there 5 or few claimants") do
  et1_group_claimants_page.main_content.additional_claimants_of_collection_type.yes.click
end

Then("I can very that the copy texts correctly dispayed for group claimants") do
  expect(et1_group_claimants_page.has_correct_translation_for_group_claimants?).to be true
end

Given("two employees making a claim") do
  @claimants = FactoryBot.create_list(:claimant, 2, :person_data)
end

Then("I should be able to submit two claimants details") do
  et1_group_claimants_page.set(@claimants)
  et1_group_claimants_page.save_and_continue
end

When("there are group claimants") do
  @claimants = FactoryBot.create_list(:claimant, 1, :group_claims)
  et1_group_claimants_page.set(@claimants)
  et1_group_claimants_upload_page.main_content.form_group.yes.click
end

Then("I can very that the copy texts correctly dispayed for Upload user details in separate spreadsheet") do
  expect(et1_group_claimants_upload_page.has_correct_translation_for_group_claimants?).to be true
end
