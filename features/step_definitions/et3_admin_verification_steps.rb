Then("it will be forwarded to the Office address {string}") do |string|
  date = Date.today
  month = t('date.month_names')[date.month]
  expect(form_submission_page).to have_submission_date(i18n_params: {submitted_date: date.strftime("%-d #{month} %Y"), office_address: string})
end

Then("phone number {string} with email {string}") do |string, email|
  expect(form_submission_page).to have_office_contact(i18n_params: {office_email: email, office_phone: string})
end

Then(/^the response should be viewable in the admin$/) do
  user = @respondent[0]
  admin_pages.login_page.load
  admin_pages.login_page.login
  admin_pages.responses_page.load
  admin_pages.responses_page.find_user(user, @my_et3_reference)
end

Then(/^the response should be viewable in the admin json$/) do
  user = @claimant[0]
  admin_pages.responses_page.check_json(user, @my_et3_reference)
end

Then(/^the minimal response should be viewable in the admin json$/) do
  user = @claimant[0]
  admin_pages.responses_page.minimal_check_json(user, @my_et3_reference)
end