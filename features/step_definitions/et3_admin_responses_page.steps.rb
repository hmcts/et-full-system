And(/^selected responses section of the admin$/) do
  admin_pages.responses_page.load
end

Then(/^I should see the ET3 responses page$/) do
  expect(page.current_url).to include("/admin/responses")
  expect(admin_pages.responses_page).to be_displayed
end

When(/^I select the edit button for the first row and change the office$/) do
  admin_pages.responses_page.change_office
end

Then(/^I should see the updated office in the responses page$/) do
  admin_pages.responses_page.load
  admin_pages.responses_page.verify_office
end

When(/^I wait for the first row to have a valid office$/) do
  sleep 60
  
end