And(/^selected responses section of the admin$/) do
  admin_pages.responses_page.load
end

Then(/^I should see the ET3 responses page$/) do
  expect(page.current_url).to include("/admin/responses")
  expect(admin_pages.responses_page).to be_displayed()
end

When(/^I select the edit button for the first row$/) do
  admin_pages.responses_page.change_office
end