Given("an employee making a claim wanting to be contacted by {string}") do |string|
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, :"contact_by_#{string}")
  @representative = FactoryBot.create_list(:representative, 1, :et1_information, :contact_by_post)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim with an invalid acas certificate wanting to be contacted by {string}") do |string|
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, :"contact_by_#{string}")
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :invalid_acas_number, :both_addresses, work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim against {string} respondents") do |string|
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  string.to_i, :yes_acas, :both_addresses)
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim with joint claim acas number") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent, 1, :no_acas, :both_addresses, :no_acas, :both_addresses, work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim with no jurisdiction") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent, 1, :no_acas, :both_addresses, :no_acas, :both_addresses, no_acas_number_reason: :"simple_form.options.respondent.no_acas_number_reason.acas_has_no_jurisdiction", work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim with employer contacted acas") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent, 1, :no_acas, :both_addresses, :no_acas, :both_addresses, no_acas_number_reason: :"simple_form.options.respondent.no_acas_number_reason.employer_contacted_acas", work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim with interim relief") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent, 1, :no_acas, :both_addresses, :no_acas, :both_addresses, no_acas_number_reason: :"simple_form.options.respondent.no_acas_number_reason.interim_relief", work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim against an employer not aware of multiple cases against the same employer") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses)
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :no_to_other_claimants)
end

Given("an employee making a claim against a trade union") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses)
  @employment = FactoryBot.create(:employment, :no_employment_details)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim against an employer who never worked for them") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :no_employment_details)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim against an employer who is working against their notice period") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :notice_period)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim against an employer who is no longer working for them") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses)
  @employment = FactoryBot.create(:employment, :employment_terminated)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim against an employer who no longer work for them") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses)
  @employment = FactoryBot.create(:employment, :notice_period)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim against an employer who is not aware of pension scheme") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses)
  @employment = FactoryBot.create(:employment, :notice_period)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim against an employer who doesn't suspect any wrongdoing at work") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses)
  @employment = FactoryBot.create(:employment, :notice_period)
  @claim = FactoryBot.create(:claim, :no_to_whistleblowing_claim)
end

Given("an employee making a unique claims") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses)
  @employment = FactoryBot.create(:employment, :notice_period)
  @claim = FactoryBot.create(:claim, :no_to_multiple_claims)
end

Given("an employee making a claim without wanting any claims outcome") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses)
  @employment = FactoryBot.create(:employment, :notice_period)
  @claim = FactoryBot.create(:claim, :nil_to_claim_outcome)
end

Given("an employee making a claim without providing anymore information") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses)
  @employment = FactoryBot.create(:employment, :notice_period)
  @claim = FactoryBot.create(:claim, :no_to_other_important_details)
end
