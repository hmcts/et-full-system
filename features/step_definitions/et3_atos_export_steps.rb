Then("it will be forwarded to the Office address {string}") do |string|
  date = Date.today
  month = t('date.month_names')[date.month]
  expect(form_submission_page).to have_submission_date(i18n_params: {submitted_date: date.strftime("%-d #{month} %Y"), office_address: string})
end

Then("phone number {string} with email {string}") do |string, email|
  expect(form_submission_page).to have_office_contact(i18n_params: {office_email: email, office_phone: string})
end
