Then(/^the response should be viewable in the admin$/) do
  user = @respondent[0]
  admin_pages.login_page.load
  admin_pages.login_page.login
  admin_pages.responses_page.load
  admin_pages.responses_page.find_user(user, @my_et3_reference)
end

Then(/^the response should be viewable in the admin json$/) do
  user = @claimant[0]
  respondent = @respondent[0]
  admin_pages.responses_page.check_json(user, @my_et3_reference)
end

Then(/^the minimal response should be viewable in the admin json$/) do
  user = @claimant[0]
  respondent = @respondent[0]
  admin_pages.responses_page.minimal_check_json(user, @my_et3_reference)
end