Given(/^I am on the ET3 disability page$/) do
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :agree_with_employment_dates)
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)
  start_a_new_et3_response
  et3_answer_respondents_details
  et3_answer_claimants_details
  et3_answer_earnings_and_benefits
  et3_answer_defend_claim_question
  et3_answer_representative
  expect(disability_page).to have_header
end

When(/^I successfully submit whether I have a disability$/) do
  et3_answer_disability_question
end

When(/^I click on next without answering the disability question$/) do
  disability_page.next
end

Then(/^I should be taken to the employers contract claim page$/) do
  expect(employers_contract_claim_page).to have_header
end

When("I click on yes without providing the required disability question") do
  user = FactoryBot.create(:et3_respondent, :et3_respondent_answers, disability_information: '')
  disability_page.disability_question.set(user.disability.to_s.split('.').last.to_sym)
  if user.disability.end_with?('.yes') && user.disability_information != nil
    disability_page.disability_information.set(user.disability_information)
  end

  disability_page.next
end

Then("I should see the error message saying the disability details cant be blank") do
  expect(disability_page).to have_error_summary
  disability_page.disability_information.assert_error_message(t('errors.disability.disability_blank'))
end
