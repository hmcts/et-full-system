Given /^a claimant continued from Saving your claim page$/ do
  @claimants = FactoryBot.create_list(:claimant, 1, :answer_data)
  start_a_new_et1_claim
  et1_answer_login
end

Then(/^an email is sent to notify user that a claim has been started$/) do
  mail = EtFullSystem::Test::MailApi.new
  expect { mail.mailhog_api['To']}.to eventually include (@claimants[0].email_address)
  expect { mail.mailhog_api['Subject'].to_s}.to eventually include ('["Employment tribunal: complete your claim"]')
  expect { mail.mailhog_api['Date'][0]}.to eventually start_with(@claim_started_time)
end

Given /^a claimant completed an ET1 form$/ do
  @claimants = FactoryBot.create_list(:first_person, 1, :person_data)
  @representative = FactoryBot.create(:representative)
  @respondents = FactoryBot.create_list(:organisation_data, 1, :employer)
  @employment = FactoryBot.create(:employment)
  @claim = FactoryBot.create(:claim)


  start_a_new_et1_claim
  et1_answer_login
  et1_answer_claimant_questions
  et1_answer_group_claimants_questions
  et1_answer_representatives_questions
  et1_answer_respondents_questions
  et1_answer_employment_details_questions
  et1_answer_claim_type_questions
  et1_answer_claim_details_questions
  et1_answer_claim_outcome_questions
  et1_answer_more_about_the_claim_questions
  et1_submit_claim

  expect(et1_claim_submitted.main_content.confirmation_tabe.tbody.local_office_address.text).to start_with("Submitted #{Time.current.strftime('%e %B %Y')}")
end

Then(/^an email is sent to notify user that a claim has been successfully submitted$/) do
  mail = EtFullSystem::Test::MailApi.new
  expect { mail.mailhog_api['To']}.to eventually include (@claimants[0].email_address)
  expect { mail.mailhog_api['Subject'].to_s}.to eventually include ('["Employment tribunal: claim submitted"]')
  expect { mail.mailhog_api['Date'][0]}.to eventually start_with(@claim_submitted_time)
end

When(/^a respondent completed an ET3 form$/) do
  @claimant = FactoryBot.create_list(:et3_claimant, 1, :disagree_with_employment_dates)
  @respondent = FactoryBot.create_list(:et3_respondent, 1, :et3_respondent_answers)
  @representative = FactoryBot.create_list(:representative, 1, :et3_information)

  start_a_new_et3_response
  et3_answer_respondents_details
  et3_answer_claimants_details
  et3_answer_earnings_and_benefits
  et3_answer_defend_claim_question
  et3_answer_representative
  et3_answer_disability_question
  et3_employers_contract_claim
  additional_information
  et3_confirmation_of_supplied_details

  expect(form_submission_page.submission_date.text).to start_with("#{Time.current.strftime('%e/%m/%Y')}")

  @my_et3_reference = form_submission_page.reference_number.text
end

Then(/^an email is sent to notify user that a respondent has been successfully submitted$/) do
  mail = EtFullSystem::Test::MailApi.new
  expect { mail.mailhog_api['To']}.to eventually include (@respondent[0].email_address)
  expect { mail.mailhog_api['Subject'].to_s}.to eventually include ('["Your Response to Employment Tribunal claim online form receipt"]')
  expect { mail.mailhog_api['Date'][0]}.to eventually start_with(@claim_submitted_time)
end