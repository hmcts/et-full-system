require 'ruby-rtf'
require 'pdf-reader'

Given("a DUMMY USER making a claim") do
  @claimant = FactoryBot.create_list(:claimant, 1, :dummy_data, )
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'M1 1AQ', expected_office: '24')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("a DUMMY USER submitting an ET1 form by uploading CSV and RTF documents") do
  @claimant = FactoryBot.create_list(:claimant, 1, :dummy_data, :group_claims)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'M1 1AQ', expected_office: '24')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :upload_your_claim_statement)
end

Given("a Male employee making a claim") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, title: :"simple_form.options.claimant.title.mr", gender: :"simple_form.options.claimant.gender.male")
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'M1 1AQ', expected_office: '24')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("a married woman employee making a claim") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, title: :"simple_form.options.claimant.title.mrs", gender: :"simple_form.options.claimant.gender.female")
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("a female employee making a claim") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, title: :"simple_form.options.claimant.title.miss", gender: :"simple_form.options.claimant.gender.female")
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'M1 1AQ', expected_office: '24')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("a claimant who does not require assistance at the tribunal hearing submitted an ET1 online") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, has_special_needs: :"simple_form.no")
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("a claimant submitting mandatory Claimant's Details fields") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, telephone_number: '', alternative_telephone_number: '', email_address: '', correspondence: :"simple_form.options.claimant.contact_preference.post")
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'M1 1AQ', expected_office: '24')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee submitting mandatory representative fields") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information, organisation_name: '', telephone_number: '', alternative_telephone_number: '', email_address: 'anonymous@example.com', dx_number: '')
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'M1 1AQ', expected_office: '24')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim where the respondent provided the same address") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent, 1, :yes_acas, :main_address, post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim where the additional respondents provided an ACAS number") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'M1 1AQ', expected_office: '24')
  @respondent.concat FactoryBot.create_list(:respondent,  1 - 1, :yes_acas, :both_addresses, :secondary)
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("an employee making a claim where the additional respondents gave reason for not having an ACAS number") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'G1 2FF', expected_office: '41')
  @respondent.concat FactoryBot.create_list(:respondent,  1 - 1, :yes_acas, :both_addresses, :secondary)
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end
Given("a claimant submitting mandatory respondent's Details fields") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, telephone_number: '', work_post_code: 'M1 1AQ', expected_office: '24')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given("a claimant submitting data to trigger a 422 error using fake ccd") do
  @claimant = FactoryBot.create_list(:claimant, 1, :fake_ccd_error_422_claimant)
  @representative = []
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, telephone_number: '', work_post_code: 'M1 1AQ', expected_office: '24')
  @employment = nil
  @claim = FactoryBot.create(:claim, :simple)
end

Given("a claimant submitting data to trigger a 422 error in a secondary claimant using fake ccd") do
  @claimant = FactoryBot.create_list(:claimant, 3, :person_data)
  @claimant[1] = FactoryBot.create(:claimant, :fake_ccd_error_422_claimant)
  @representative = []
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, telephone_number: '', work_post_code: 'M1 1AQ', expected_office: '24')
  @employment = nil
  @claim = FactoryBot.create(:claim, :simple)
end

Given("an multiple claimants making a claim by uploading a Rich Text Format document") do
  @claimant = FactoryBot.create_list(:claimant, 3, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'G1 2FF', expected_office: '41')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :upload_your_claim_statement)
end

Given("an employee submitting an ET1 form by uploading CSV and RTF documents") do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, :group_claims)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'M1 1AQ', expected_office: '24')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :upload_your_claim_statement)
end

Then /^the claim should be present in CCD$/ do
  admin_api = EtFullSystem::Test::AdminApi.new
  office = @respondent[0]["expected_office"]
  ccd_office_lookup = ::EtFullSystem::Test::CcdOfficeLookUp
  ccd_object = EtFullSystem::Test::Ccd::Et1CcdSingleClaimant.find_by_reference(@claim_reference, ccd_office_lookup.office_lookup[office][:single][:case_type_id])

  ccd_object.assert_primary_reference(@claim_reference)
  ccd_object.assert_primary_claimants(@claimant)
  ccd_object.assert_primary_representative(@representative)
  ccd_object.assert_primary_employment(@employment, @claimant)
  ccd_object.assert_claimant_work_address(@respondent.first)
  ccd_object.assert_respondents(@respondent)
  expect(ccd_object.find_pdf_file).to match_et1_pdf_for(claim: @claim, claimants: @claimant, representative: @representative.first, respondents: @respondent, employment: @employment)
end

Then /^the claim should be present in CCD with an attached acas certificate$/ do
  office = @respondent[0]["expected_office"]
  ccd_office_lookup = ::EtFullSystem::Test::CcdOfficeLookUp
  ccd_object = EtFullSystem::Test::Ccd::Et1CcdSingleClaimant.find_by_reference(@claim_reference, ccd_office_lookup.office_lookup[office][:single][:case_type_id])

  ccd_object.assert_primary_reference(@claim_reference)
  ccd_object.assert_primary_claimants(@claimant)
  ccd_object.assert_primary_representative(@representative)
  ccd_object.assert_primary_employment(@employment, @claimant)
  ccd_object.assert_claimant_work_address(@respondent.first)
  ccd_object.assert_respondents(@respondent)
  ccd_object.assert_acas_pdf_file
  expect(ccd_object.find_pdf_file).to match_et1_pdf_for(claim: @claim, claimants: @claimant, representative: @representative.first, respondents: @respondent, employment: @employment)
end

Then /^the PDF file should be present in CCD$/ do
  office = @respondent[0]["expected_office"]
  claimant = @claimant[0]
  ccd_office_lookup = ::EtFullSystem::Test::CcdOfficeLookUp
  ccd_object = EtFullSystem::Test::Ccd::Et1CcdSingleClaimant.find_by_reference(@claim_reference, ccd_office_lookup.office_lookup[office][:single][:case_type_id])

  ccd_object.assert_primary_reference(@claim_reference)
  ccd_object.assert_primary_claimants(@claimant)
  ccd_object.assert_primary_representative(@representative)
  ccd_object.assert_primary_employment(@employment, @claimant)
  ccd_object.assert_claimant_work_address(@respondent.first)
  ccd_object.assert_respondents(@respondent)

  expect(ccd_object.find_pdf_file).to match_et1_pdf_for(claim: @claim, claimants: @claimant, representative: @representative.first, respondents: @respondent, employment: @employment)
  expect(ccd_object.as_json['response']['case_fields']['documentCollection'][1]['value']['uploadedDocument']['document_filename'].downcase) == (%W[et1_attachment_#{claimant[:first_name].underscore}_#{claimant[:last_name].downcase.delete("'")}.pdf])
end

Then /^the multiple claimants should be present in CCD$/ do
  admin_api = EtFullSystem::Test::AdminApi.new
  claim = admin_api.exported_to_ccd_claim(reference: @claim_reference)
  office = @respondent[0]["expected_office"]
  ccd_office_lookup = ::EtFullSystem::Test::CcdOfficeLookUp

  multiple_reference = claim.dig('last_ccd_export', 'external_data', 'case_reference')
  ccd_object = EtFullSystem::Test::Ccd::Et1CcdMultipleClaimants.find_multiples_by_reference(multiple_reference, ccd_office_lookup.office_lookup[office][:multiple][:case_type_id]) do
    broadcast_message("Waiting for multiples for reference #{@claim_reference} to be sent to CCD")
    page.execute_script('true')
  end
  raise "multiple not found for reference #{@claim_reference} looking for multiple reference #{multiple_reference} at #{Time.now.strftime('%d/%m/%y %H:%M:%S')}" if ccd_object.nil?
  ccd_object.assert_multiple_title(@respondent.first.name)

  ccd_object.assert_primary_claimant(@claimant, @representative, @employment, @respondent, @claim_reference, ccd_office_lookup.office_lookup[office][:single][:case_type_id], @claim)

  if @claimant[0].dig(:group_claims_csv)
    ccd_object.assert_secondary_xls_claimants(@claimant, @representative, @employment, @respondent, ccd_office_lookup.office_lookup[office][:single][:case_type_id])
    expect(ccd_object.find_csv_file(ccd_office_lookup.office_lookup[office][:single][:case_type_id])).to be_present
  else
    ccd_object.assert_secondary_claimant(@claimant, @representative, @employment, @respondent, ccd_office_lookup.office_lookup[office][:single][:case_type_id])
  end

  expect(ccd_object.find_pdf_file(ccd_office_lookup.office_lookup[office][:single][:case_type_id])).to match_et1_pdf_for(claim: @claim, claimants: @claimant, representative: @representative.first, respondents: @respondent, employment: @employment)
end

Given("{string} employees making a claim with multiple respondents") do |string|
  @claimant = FactoryBot.create_list(:claimant, string.to_i, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)

  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'G1 2FF', expected_office: '41')
  @respondent.concat FactoryBot.create_list(:respondent,  string.to_i - 1, :yes_acas, :both_addresses, :secondary)
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end


Given(/^a claimant submitted an ET1 with a work post code of "([^"]*)"$/) do |post_code|
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: post_code, expected_office: '99')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Then(/^the claim should be present in the "([^"]*)" office CCD system$/) do |office|
  ccd_office_lookup = ::EtFullSystem::Test::CcdOfficeLookUp
  ccd_object = EtFullSystem::Test::Ccd::Et1CcdSingleClaimant.find_by_reference(@claim_reference, ccd_office_lookup.office_lookup[office][:single][:case_type_id])

  ccd_object.assert_primary_reference(@claim_reference)
  ccd_object.assert_primary_claimants(@claimant)
  ccd_object.assert_primary_representative(@representative)
  ccd_object.assert_primary_employment(@employment, @claimant)
  ccd_object.assert_claimant_work_address(@respondent.first)
  ccd_object.assert_respondents(@respondent)

  expect(ccd_object.find_pdf_file).to match_et1_pdf_for(claim: @claim, claimants: @claimant, representative: @representative.first, respondents: @respondent, employment: @employment)
end

Given(/^a claimant submitting data to trigger a 502 error once only in a secondary claimant using fake ccd$/) do
  @claimant = FactoryBot.create_list(:claimant, 3, :person_data)
  @claimant[1] = FactoryBot.create(:claimant, :fake_ccd_error_502_once_claimant)
  @representative = []
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, telephone_number: '', work_post_code: 'M1 1AQ', expected_office: '24')
  @employment = nil
  @claim = FactoryBot.create(:claim, :simple)
end

Given(/^a claimant submitting data to trigger a 401 error for the first 3 requests using fake ccd$/) do
  @claimant = FactoryBot.create_list(:claimant, 1, :person_data, :contact_by_post)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information, :contact_by_post)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'BT11AE', expected_office: '61')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

Given(/^a claimant submitting data to trigger a 401 error for the first 3 requests of every secondary claimant using fake ccd$/) do
  @claimant = FactoryBot.create_list(:claimant, 2, :person_data, :contact_by_post)
  @representative = FactoryBot.create_list(:representative, 1, :et1_information, :contact_by_post)
  @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'BT11AE', expected_office: '61')
  @employment = FactoryBot.create(:employment, :still_employed)
  @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
end

And(/^the CCD claim should have (\d+) ACAS certificates$/) do |number|
  office = @respondent[0]["expected_office"]
  ccd_office_lookup = ::EtFullSystem::Test::CcdOfficeLookUp
  ccd_object = EtFullSystem::Test::Ccd::Et1CcdSingleClaimant.find_by_reference(@claim_reference, ccd_office_lookup.office_lookup[office][:single][:case_type_id])
  expected_names = @respondent[0..number].map { |r| "acas_#{r[:name]}.pdf" }
  expect(ccd_object.find_acas_names(number)).to match_array(expected_names)
end

And(/^the PDF is converted correctly$/) do
  office = @respondent[0]["expected_office"]
  ccd_office_lookup = ::EtFullSystem::Test::CcdOfficeLookUp
  ccd_object = EtFullSystem::Test::Ccd::Et1CcdSingleClaimant.find_by_reference(@claim_reference, ccd_office_lookup.office_lookup[office][:single][:case_type_id])

  ccd_pdf = ccd_object.find_pdf_attachment
  reader = PDF::Reader.new(ccd_pdf)
  pdf_content_first_line = reader.pages[0].text.lines.first.strip
  pdf_content_second_line = reader.pages[0].text.lines.second.strip

  rtf_text_first_line = nil
  rtf_text_second_line = nil
  rtf_file = 'features/support/fixtures/simple_user_with_rtf.rtf'
  silence_warnings do
    rtf_content = File.read(rtf_file)
    parser = RubyRTF::Parser.new
    rtf_text_first_line = parser.parse(rtf_content).sections.first[:text].strip
    rtf_text_second_line = parser.parse(rtf_content).sections.second[:text].strip
  end

  expect(File.size(ccd_pdf)).not_to eq(File.size(rtf_file))
  expect(rtf_text_first_line.length).to eq(pdf_content_first_line.length)
  expect(rtf_text_second_line.length).to eq(pdf_content_second_line.length)
end