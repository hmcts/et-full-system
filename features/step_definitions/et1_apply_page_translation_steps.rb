Given("a claimant is on the Apply page") do
  load_start_page
end

Then("Apply page copy texts are displayed in the correct language") do
  expect(et1_new_claim_page.has_correct_translation?).to be true
end

When("user click on Your feedback link") do
  et1_new_claim_page.feedback_notice.feedback_link.click
end

Then("user is taken to the feedback page") do
  et1_new_claim_page.has_load_your_feedback_page
end