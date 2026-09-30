Then('I see the cookie banner is present') do
  expect(et1_apply_page.cookie).to have_header
  expect(et1_apply_page.cookie).to have_accept_button
  expect(et1_apply_page.cookie).to have_reject_button
end

When('I accept the cookies') do
  et1_apply_page.cookie.accept_button.click
end

When('I reject the cookies') do
  et1_apply_page.cookie.reject_button.click
end

Then('I see the cookie banner is not present') do
  expect(et1_apply_page.cookie).to have_no_header
end

Given('I visit the homepage') do
  load_et1_start_page
end
