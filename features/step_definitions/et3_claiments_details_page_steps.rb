Given(/^I am on the ET3 claimants details page$$/) do
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :agree_with_employment_dates)
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
  et3_answer_claimants_details
end

When(/^I successfully submit required claimants details only$/) do
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

# Then(/^I should see the error message saying the further information about dates cant be blank$/) do
#   claimants_details_page.employment_start.assert_error_message(t('errors.claimants_details.start_date_blank'))
#   claimants_details_page.employment_end.assert_error_message(t('errors.claimants_details.end_date_blank'))
# end
