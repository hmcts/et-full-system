Then('I should see valid claim submitted page') do
  office_data = admin_api.office_data_for(@respondent[0][:expected_office])
  expect(et1_claim_submitted.has_correct_translation?(@claim_reference, @claim[:rtf_file],
                                                      @claimant[0][:group_claims_csv], office_data)).to be true
end

Given('claimant home postcode {string} then submission office will be {string}') do |string, string2|
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent, 1, :yes_acas, :main_address, post_code: string,
                                                                                 expected_office: string2)
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given('claimant work postcode {string} then submission office will be {string}') do |string, string2|
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent, 1, :yes_acas, :main_address, post_code: string,
                                                                                 expected_office: string2)
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given('a group claimaints submitting an ET1 form by uploading CSV and Rich Text Format documents') do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, :group_claims)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent, 1, :both_addresses, :yes_acas)
  @employment = FactoryBot.create(:employment, :no_employment_details)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end
