Then(/^I can download the ET3 form and validate in TXT format$/) do
  api = EtFullSystem::Test::AdminApi.new atos_interface: atos_interface
  zip_file = api.atos_zip_file_for(reference: @my_et3_reference, ignore_before: @test_start_time)
  expect(zip_file.download_file(:et3_response_txt_for, user: @respondent[0], reference: @my_et3_reference, ignore_before: @test_start_time)).to match_text_schema calculated_response_matchers(user: @claimant[0], representative: @representative[0], respondent: @respondent[0])
end


Then(/^I can download the ET3 form and validate in PDF format$/) do
  api = EtFullSystem::Test::AdminApi.new atos_interface: atos_interface
  zip_file = api.atos_zip_file_for(reference: @my_et3_reference, ignore_before: @test_start_time)
  tempfile = zip_file.download_file(:et3_response_pdf_for, user: @respondent[0], reference: @my_et3_reference, ignore_before: @test_start_time)
  pdf_file = EtFullSystem::Test::FileObjects::Et3PdfFile.new(tempfile, locale: EtFullSystem::Test::Messaging.instance.current_locale)
  expect(pdf_file).to have_correct_contents_for(response: @claimant[0],
    respondent: @respondent[0],
    representative: @representative[0],
    indent: 1)
end

Then("I can download the ET3 form from the secondary atos and validate that the filename starts with '99'") do
  api = EtFullSystem::Test::AdminApi.new atos_interface: atos_secondary_interface
  zip_file = api.atos_zip_file_for(reference: @my_et3_reference, ignore_before: @test_start_time)
  expect(zip_file.download_file(:et3_filename_start_with, user: @respondent[0], reference: @my_et3_reference, local_postcode: '99', ignore_before: @test_start_time)).to be_present
end

Then("I can download the ET3 form and validate that the filename starts with {string}") do |string|
  api = EtFullSystem::Test::AdminApi.new atos_interface: atos_interface
  zip_file = api.atos_zip_file_for(reference: @my_et3_reference, ignore_before: @test_start_time)
  expect(zip_file.download_file(:et3_filename_start_with, user: @respondent[0], reference: @my_et3_reference, local_postcode: string, ignore_before: @test_start_time)).to be_present
end

Then("it will be forwarded to the Office address {string}") do |string|
  date = Date.today
  month = t('date.month_names')[date.month]
  expect(form_submission_page).to have_submission_date(i18n_params: {submitted_date: date.strftime("%-d #{month} %Y"), office_address: string})
end

Then("phone number {string} with email {string}") do |string, email|
  expect(form_submission_page).to have_office_contact(i18n_params: {office_email: email, office_phone: string})
end
