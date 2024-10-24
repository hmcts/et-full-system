Given("a claimant is on the Return to your claim page") do
  load_et1_start_page
  et1_apply_page.return_to_claim
end

Then("Return to your claim copy texts are displayed in the correct language") do
  expect(et1_return_to_your_claim_page.has_correct_translation?).to be true
end

Given("I'm a return claimant") do
  start_a_new_et1_claim
  @claim_number = et1_application_number_page.claim_number_notification.claims_number.text
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, claim_number: @claim_number)
  et1_answer_login
  @page_left_off = current_path
  page.reset!
  load_et1_start_page
  et1_apply_page.return_to_claim
end

When("I enter my claim details") do
  et1_return_to_your_claim_page.set(@claimant)
  et1_return_to_your_claim_page.find_my_claim
end

Then("I should be taken to where I was left off") do
  expect(current_path).to eq( @page_left_off)
end

When("I click Start a new claim") do
  et1_return_to_your_claim_page.start_a_new_claim
end

Then("I should be taken to Start a new claim page") do
  expect(et1_apply_page.header.text).to be_truthy
end

When("I enter my claim number but not my password") do
  et1_return_to_your_claim_page.set_user(@claimant)
  et1_return_to_your_claim_page.find_my_claim
end

Then("I should see an error message pop up") do
  expect(et1_return_to_your_claim_page.memorable_word_valid?).to be true
end

When(/^I reset my password to "([^"]*)"$/) do |new_password|
  @claimant[0].memorable_word = new_password
  et1_return_to_your_claim_page.reset_memorable_word
    .using(email_address: @claimant[0].email_address, claim_number: @claim_number)
    .assert_memorable_word_email_sent
  et1_reset_memorable_word_page.from_email_for(@claimant[0].email_address)
    .set_memorable_word(new_password)
    .assert_memorable_word_updated
end

When("I forget my details and input the wrong email") do
  et1_return_to_your_claim_page.reset_memorable_word
      .using(email_address: @claimant[0].email_address, claim_number: @claim_number)
      .assert_memorable_word_email_sent
  et1_return_to_your_claim_page.reset_memorable_word
  et1_reset_email_memorableword_page.submit
end

Then("I should see an error message") do
  expect(et1_reset_email_memorableword_page.valid?).to be true
end
