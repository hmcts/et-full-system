Given(/^an employer responds to a claim$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)
end

Given(/^an employer responds to a claim with no respresentative$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  @representative = FactoryBot.create_list(:representative, 1, :et3_no_representative)
end

Given(/^an employer respond yes to 'Are the dates of employment given by the claimant correct'$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :agree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)
end

Given("an employer responds to a claim with case number starting {string}") do |string|
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers, case_number: "#{string}")
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)
end

When(/^an employer responds to a claim with an additional information$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers, :upload_additional_information)
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)
end

Given(/^an employer responds to an existing claim$/) do
  @existing_claim = create_any_claim_in_ccd
  ethos_case_reference = @existing_claim.ethos_case_reference
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers, case_number: ethos_case_reference)
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)
end

Given(/^an employer responds to an existing external reformed case for england and wales Bristol office$/) do
  existing_claim = create_reformed_claim_in_ccd(office_code: 60)
  ethos_case_reference = existing_claim.dig('case_fields', 'ethosCaseReference')
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers, case_number: ethos_case_reference)
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)
end

Then(/the response should have been moved to the Bristol office/) do
  admin_api.wait_for_response_in_office(@my_et3_reference, '14')
end
