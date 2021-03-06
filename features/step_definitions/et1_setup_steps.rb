Given(/^an employee making a claim$/) do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_with_no_gender_information)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses)
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given(/^an employee making a claim without a respresentative$/) do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_no_representative)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("{string} employees making a claim") do |string|
  @claimant = FactoryBot.create_list(:claimant, string.to_i, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'M1 1AQ', expected_office: '24')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given(/^7 employees making a claim by uploading CSV file$/) do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, :group_claims)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'M1 1AQ', expected_office: '24')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given(/^an employee making a claim by uploading a Rich Text Format document$/) do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :upload_your_claim_statement)
end

Given("an employee making a claim against {int} employers") do |string|
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'M1 1AQ', expected_office: '24')
  @respondent.concat FactoryBot.create_list(:respondent,  string - 1, :yes_acas, :both_addresses, :secondary)
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("a claimant submitted an ET1 form without providing a work address {string}") do |string|
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent, 1, :yes_acas, post_code: string, work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)

  start_a_new_et1_claim
  et1_answer_login
  et1_answer_claimant_questions
  et1_answer_group_claimants_questions
  et1_answer_representatives_questions
  et1_answer_respondents_questions
  et1_answer_employment_details_questions
  et1_answer_claim_type_questions
  et1_answer_claim_details_questions
  et1_answer_claim_outcome_questions
  et1_answer_more_about_the_claim_questions
  et1_submit_claim
end

Given("a claimant submitted an ET1 form with work address WD187SQ") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses)
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)

  start_a_new_et1_claim
  et1_answer_login
  et1_answer_claimant_questions
  et1_answer_group_claimants_questions
  et1_answer_representatives_questions
  et1_answer_respondents_questions
  et1_answer_employment_details_questions
  et1_answer_claim_type_questions
  et1_answer_claim_details_questions
  et1_answer_claim_outcome_questions
  et1_answer_more_about_the_claim_questions
  et1_submit_claim
end

When("a claimant submitted an ET1 with special characters in the first and last name") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, first_name: 'N/A.*_', last_name: "N/A.*#{Time.now.to_i}")
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses)
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)

  start_a_new_et1_claim
  et1_answer_login
  et1_answer_claimant_questions
  et1_answer_group_claimants_questions
  et1_answer_representatives_questions
  et1_answer_respondents_questions
  et1_answer_employment_details_questions
  et1_answer_claim_type_questions
  et1_answer_claim_details_questions
  et1_answer_claim_outcome_questions
  et1_answer_more_about_the_claim_questions
  et1_submit_claim
end

Given("a claimant submitted an ET1 with no employment details") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses)
  @employment = FactoryBot.create(:employment, :no_employment_details)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("a claimant submitted an ET1 who live outside UK") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, country: :"simple_form.options.claimant.address_country.other", post_code: "^&%$??@:?<*")
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end
