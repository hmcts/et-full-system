Given(/^I am on the ET3 claimants details page$$/) do
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  start_a_new_et3_response
  et3_answer_respondents_details
end

Then("Claimants details page copy texts are displayed in the correct language") do
  claimants_details_page.agree_with_early_conciliation_details_question.set(:no)
  claimants_details_page.agree_with_employment_dates_question.set(:no)
  claimants_details_page.agree_with_claimants_description_of_job_or_title_question.set(:no)

  expect(claimants_details_page.has_correct_translation?).to be true
end

When(/^I successfully submit all the claimants details$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates)
  et3_answer_claimants_details
end

When(/^I successfully submit required claimants details only$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :agree_with_employment_dates)
  et3_answer_required_claimants_details
end

Then(/^I should be taken to the earnings and benefits page$/) do
  expect(earnings_and_benefits_page).to have_header
end

But(/^I do not provide the correct employment dates or give a reason$/) do
  claimants_details_page.next
end

When(/^I select no to are the dates given by the claimant correct$/) do
  claimants_details_page.agree_with_employment_dates_question.set(:no)
end

And(/^I enter invalid dates in the incorrect format$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates_invalid_date)
  et3_answer_claimants_details
end

Then(/^I should still be on the claimant details page and not on the earnings and benefits page$/) do
  expect(claimants_details_page).to have_header
end