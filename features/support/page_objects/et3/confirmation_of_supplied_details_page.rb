require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class ConfirmationOfSuppliedDetailsPage < BasePage
        include EtTestHelpers::Page
        include RSpec::Matchers
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :govuk_link, :'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        # Confirmation of Supplied Details
        element :header, :content_header, 'confirmation.header'
        section :main_header, '.content-header' do

        end
        gds_text_input :email_receipt_question, :'questions.email_receipt.label', exact: false
        section :confirmation_of_respondents_details_answers, :govuk_summary_list, :'questions.confirmation_of_respondents_details_answers.caption', exact: true do
          section :case_number_row, :govuk_summary_list_row, :'questions.case_number.label', exact: true do
            element :case_number_answer, :govuk_summary_list_col
          end
          section :name_row, :govuk_summary_list_row, :'questions.name.label', exact: true do
            element :name_answer, :govuk_summary_list_col
          end
          section :company_number_row, :govuk_summary_list_row, :'questions.company_number.label', exact: true do
            element :company_number_answer, :govuk_summary_list_col
          end
          section :type_of_employer_row, :govuk_summary_list_row, :'questions.type_of_employer.label', exact: true do
            element :type_of_employer_answer, :govuk_summary_list_col
          end
          section :title_row, :govuk_summary_list_row, :'questions.title.label', exact: true do
            element :title_answer, :govuk_summary_list_col
          end
          section :contact_row, :govuk_summary_list_row, :'questions.contact.label', exact: true do
            element :contact_answer, :govuk_summary_list_col
          end
          section :building_name_row, :govuk_summary_list_row, :'questions.building_name.label', exact: true do
            element :building_name_answer, :govuk_summary_list_col
          end
          section :street_row, :govuk_summary_list_row, :'questions.street.label', exact: true do
            element :street_answer, :govuk_summary_list_col
          end
          section :town_row, :govuk_summary_list_row, :'questions.town.label', exact: true do
            element :town_answer, :govuk_summary_list_col
          end
          section :county_row, :govuk_summary_list_row, :'questions.county.label', exact: true do
            element :county_answer, :govuk_summary_list_col
          end
          section :postcode_row, :govuk_summary_list_row, :'questions.postcode.label', exact: true do
            element :postcode_answer, :govuk_summary_list_col
          end
          section :dx_number_row, :govuk_summary_list_row, :'questions.dx_number.label', exact: true do
            element :dx_number_answer, :govuk_summary_list_col
          end
          section :contact_number_row, :govuk_summary_list_row, :'questions.contact_number.label', exact: true do
            element :contact_number_answer, :govuk_summary_list_col
          end
          section :mobile_number_row, :govuk_summary_list_row, :'questions.contact_mobile_number.label', exact: true do
            element :mobile_number_answer, :govuk_summary_list_col
          end
          section :contact_preference_row, :govuk_summary_list_row, :'questions.contact_preference.label', exact: true do
            element :contact_preference_answer, :govuk_summary_list_col
          end
          section :email_address_row, :govuk_summary_list_row, :'questions.contact_preference.email.input_label', exact: true do
            element :email_address_answer, :govuk_summary_list_col
          end
          section :organisation_employ_gb_row, :govuk_summary_list_row, :'questions.organisation_employ_gb.label', exact: true do
            element :organisation_employ_gb_answer, :govuk_summary_list_col
          end
          section :organisation_more_than_one_site_row, :govuk_summary_list_row, :'questions.organisation_more_than_one_site.label', exact: true do
            element :organisation_more_than_one_site_answer, :govuk_summary_list_col
          end
          section :allow_phone_or_video_attendance_row, :govuk_summary_list_row, :'questions.allow_phone_or_video_attendance.label', exact: true do
            element :allow_phone_or_video_attendance_answer, :govuk_summary_list_col
          end
          section :employment_at_site_number_row, :govuk_summary_list_row, :'questions.organisation_more_than_one_site.employment_at_site_number.label', exact: true do
            element :employment_at_site_number_answer, :govuk_summary_list_col
          end
          element :back_to_top, :govuk_link, :'confirmation.back_to_the_top'
        end

        section :confirmation_of_claimants_details_answers, :govuk_summary_list, :'questions.confirmation_of_claimants_details_answers.caption', exact: true do
          section :claimants_name_row, :govuk_summary_list_row, :'questions.claimants_name.label', exact: true do
            element :claimants_name_answer, :govuk_summary_list_col
          end
          section :agree_with_early_conciliation_details_row, :govuk_summary_list_row, :'questions.agree_with_early_conciliation_details.label', exact: true do
            element :agree_with_early_conciliation_details_answer, :govuk_summary_list_col
          end
          section :disagree_conciliation_reason_row, :govuk_summary_list_row, :'questions.agree_with_early_conciliation_details.disagree_conciliation_reason.label', exact: true do
            element :disagree_conciliation_reason_answer, :govuk_summary_list_col
          end
          section :agree_with_employment_dates_row, :govuk_summary_list_row, :'questions.agree_with_employment_dates.label', exact: true do
            element :agree_with_employment_dates_answer, :govuk_summary_list_col
          end
          section :employment_start_row, :govuk_summary_list_row, :'questions.agree_with_employment_dates.employment_start.label', exact: true do
            element :employment_start_answer, :govuk_summary_list_col
          end
          section :employment_end_row, :govuk_summary_list_row, :'questions.agree_with_employment_dates.employment_end.label', exact: true do
            element :employment_end_answer, :govuk_summary_list_col
          end
          section :disagree_employment_row, :govuk_summary_list_row, :'questions.agree_with_employment_dates.disagree_employment.label', exact: true do
            element :disagree_employment_answer, :govuk_summary_list_col
          end
          section :continued_employment_row, :govuk_summary_list_row, :'questions.continued_employment.label', exact: true do
            element :continued_employment_answer, :govuk_summary_list_col
          end
          section :agree_with_claimants_description_of_job_or_title_row, :govuk_summary_list_row, :'questions.agree_with_claimants_description_of_job_or_title.label', exact: true do
            element :agree_with_claimants_description_of_job_or_title_answer, :govuk_summary_list_col
          end
          section :disagree_claimants_job_or_title_row, :govuk_summary_list_row, :'questions.agree_with_claimants_description_of_job_or_title.disagree_claimants_job_or_title.label', exact: true do
            element :disagree_claimants_job_or_title_answer, :govuk_summary_list_col
          end
          element :back_to_top, :govuk_link, :'confirmation.back_to_the_top'
        end

        section :confirmation_of_earnings_and_benefits_answers, :govuk_summary_list, :'questions.confirmation_of_earnings_and_benefits_answers.caption', exact: true do
          section :agree_with_claimants_hours_row, :govuk_summary_list_row, :'questions.agree_with_claimants_hours.label', exact: true do
            element :agree_with_claimants_hours_answer, :govuk_summary_list_col
          end
          section :queried_hours_row, :govuk_summary_list_row, :'questions.agree_with_claimants_hours.queried_hours.label', exact: true do
            element :queried_hours_answer, :govuk_summary_list_col
          end
          section :agree_with_earnings_details_row, :govuk_summary_list_row, :'questions.agree_with_earnings_details.label', exact: true do
            element :agree_with_earnings_details_answer, :govuk_summary_list_col
          end
          section :queried_pay_before_tax_row, :govuk_summary_list_row, :'questions.agree_with_earnings_details.queried_pay_before_tax.label', exact: true do
            element :queried_pay_before_tax_answer, :govuk_summary_list_col
          end
          section :queried_pay_before_tax_period_row, :govuk_summary_list_row, :'questions.agree_with_earnings_details.queried_pay_before_tax_period.label', exact: true do
            element :queried_pay_before_tax_period_answer, :govuk_summary_list_col
          end
          section :queried_take_home_pay_row, :govuk_summary_list_row, :'questions.agree_with_earnings_details.queried_take_home_pay.label', exact: true do
            element :queried_take_home_pay_answer, :govuk_summary_list_col
          end
          section :queried_take_home_pay_period_row, :govuk_summary_list_row, :'questions.agree_with_earnings_details.queried_take_home_pay_period.label', exact: true do
            element :queried_take_home_pay_period_answer, :govuk_summary_list_col
          end
          section :agree_with_claimant_notice_row, :govuk_summary_list_row, :'questions.agree_with_claimant_notice.label', exact: true do
            element :agree_with_claimant_notice_answer, :govuk_summary_list_col
          end
          section :disagree_claimant_notice_reason_row, :govuk_summary_list_row, :'questions.agree_with_claimant_notice.disagree_claimant_notice_reason.label', exact: true do
            element :disagree_claimant_notice_reason_answer, :govuk_summary_list_col
          end
          section :agree_with_claimant_pension_benefits_row, :govuk_summary_list_row, :'questions.agree_with_claimant_pension_benefits.label', exact: true do
            element :agree_with_claimant_pension_benefits_answer, :govuk_summary_list_col
          end
          section :disagree_claimant_pension_benefits_reason_row, :govuk_summary_list_row, :'questions.agree_with_claimant_pension_benefits.disagree_claimant_pension_benefits_reason.label', exact: true do
            element :disagree_claimant_pension_benefits_reason_answer, :govuk_summary_list_col
          end
          element :back_to_top, :govuk_link, :'confirmation.back_to_the_top'
        end

        section :confirmation_of_response_answers, :govuk_summary_list, :'questions.confirmation_of_response_answers.caption', exact: true do
          section :defend_claim_row, :govuk_summary_list_row, :'questions.defend_claim.label', exact: true do
            element :defend_claim_answer, :govuk_summary_list_col
          end
          section :defend_claim_facts_row, :govuk_summary_list_row, :'questions.defend_claim_facts.label', exact: true do
            element :defend_claim_facts_answer, :govuk_summary_list_col
          end
          element :back_to_top, :govuk_link, :'confirmation.back_to_the_top'
        end

        section :confirmation_of_your_representative_answers, :govuk_summary_list, :'questions.confirmation_of_your_representative_answers.caption', exact: true do
          section :have_representative_row, :govuk_summary_list_row, :'questions.have_representative.label', exact: true do
            element :have_representative_answer, :govuk_summary_list_col
          end
          element :back_to_top, :govuk_link, :'confirmation.back_to_the_top'
        end

        section :confirmation_of_your_representatives_details_answers, :govuk_summary_list, :'questions.confirmation_of_your_representatives_details_answers.caption', exact: true do
          section :type_of_representative_row, :govuk_summary_list_row, :'questions.type_of_representative.label', exact: true do
            element :type_of_representative_answer, :govuk_summary_list_col
          end
          section :representative_org_name_row, :govuk_summary_list_row, :'questions.representative_org_name.label', exact: true do
            element :representative_org_name_answer, :govuk_summary_list_col
          end
          section :representative_name_row, :govuk_summary_list_row, :'questions.representative_name.label', exact: true do
            element :representative_name_answer, :govuk_summary_list_col
          end
          section :representative_building_row, :govuk_summary_list_row, :'questions.representative_building.label', exact: true do
            element :representative_building_answer, :govuk_summary_list_col
          end
          section :representative_street_row, :govuk_summary_list_row, :'questions.representative_street.label', exact: true do
            element :representative_street_answer, :govuk_summary_list_col
          end
          section :representative_town_row, :govuk_summary_list_row, :'questions.representative_town.label', exact: true do
            element :representative_town_answer, :govuk_summary_list_col
          end
          section :representative_county_row, :govuk_summary_list_row, :'questions.representative_county.label', exact: true do
            element :representative_county_answer, :govuk_summary_list_col
          end
          section :representative_postcode_row, :govuk_summary_list_row, :'questions.representative_postcode.label', exact: true do
            element :representative_postcode_answer, :govuk_summary_list_col
          end
          section :representative_phone_row, :govuk_summary_list_row, :'questions.representative_phone.label', exact: true do
            element :representative_phone_answer, :govuk_summary_list_col
          end
          section :representative_mobile_row, :govuk_summary_list_row, :'questions.representative_mobile.label', exact: true do
            element :representative_mobile_answer, :govuk_summary_list_col
          end
          section :representative_dx_number_row, :govuk_summary_list_row, :'questions.representative_dx_number.label', exact: true do
            element :representative_dx_number_answer, :govuk_summary_list_col
          end
          section :representative_reference_row, :govuk_summary_list_row, :'questions.representative_reference.label', exact: true do
            element :representative_reference_answer, :govuk_summary_list_col
          end
          section :representative_contact_preference_row, :govuk_summary_list_row, :'questions.representative_contact_preference.label', exact: true do
            element :representative_contact_preference_answer, :govuk_summary_list_col
          end
          section :email_row, :govuk_summary_list_row, :'questions.representative_contact_preference.email.input_label', exact: true do
            element :email_answer, :govuk_summary_list_col
          end
          section :allow_phone_or_video_attendance_row, :govuk_summary_list_row, :'questions.allow_phone_or_video_attendance.label', exact: true do
            element :allow_phone_or_video_attendance_answer, :govuk_summary_list_col
          end
          element :back_to_top, :govuk_link, :'confirmation.back_to_the_top'
        end

        section :confirmation_of_disability_answers, :govuk_summary_list, :'questions.confirmation_of_disability_answers.caption', exact: true do
          section :disability_row, :govuk_summary_list_row, :'questions.disability.label', exact: true do
            element :disability_answer, :govuk_summary_list_col
          end
          section :disability_information_row, :govuk_summary_list_row, :'questions.disability.disability_information.label', exact: true do
            element :disability_information_answer, :govuk_summary_list_col
          end
          element :back_to_top, :govuk_link, :'confirmation.back_to_the_top'
        end

        section :confirmation_of_employer_contract_claim_answers, :govuk_summary_list, :'questions.confirmation_of_employer_contract_claim_answers.caption', exact: true do
          section :make_employer_contract_claim_row, :govuk_summary_list_row, :'confirmation_of_supplied_details.make_employer_contract_claim', exact: true do
            element :make_employer_contract_claim_answer, :govuk_summary_list_col
          end
          section :claim_information_row, :govuk_summary_list_row, :'questions.claim_information.label', exact: true do
            element :claim_information_answer, :govuk_summary_list_col
          end
          element :edit_answers_link, :govuk_link, :'questions.confirmation_of_employer_contract_claim_answers.edit_answers'
          element :back_to_top, :govuk_link, :'confirmation.back_to_the_top'
        end

        section :confirmation_of_additional_information_answers, :govuk_summary_list, :'questions.confirmation_of_additional_information_answers.caption', exact: true do
          section :upload_additional_information_row, :govuk_summary_list_row, :'confirmation_of_supplied_details.upload_additional_information', exact: true do
            element :upload_additional_information_answer, :govuk_summary_list_col
          end
        end
        # Submit Form
        gds_submit_button :continue_button, :'confirmation.submit'
        def next
          continue_button.click
        end

        def switch_to_welsh
          switch_language.welsh_link.click
        end

        def switch_to_english
          switch_language.english_link.click
        end
      end
    end
  end
end
