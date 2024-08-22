require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class RespondentsDetailsPage < BasePage
        include RSpec::Matchers
        include EtTestHelpers::Page
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :govuk_link, :'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        # Respondent's Details
        element :header, :content_header, 'respondents_details.header'
        # @!method error_summary
        #   A govuk error component
        #   @return [EtTestHelpers::Components::GovUKErrorSummary] The site prism section
        gds_error_summary :error_summary, :'errors.header'
        # Case number
        gds_text_input :case_number_question, :'questions.case_number.label', exact: false
        # Name of individual, company or organisation
        gds_text_input :name_question, :'questions.name.label'
        gds_text_input :company_number_question, :'questions.company_number.label', exact: false
        gds_select :type_of_employer_question, :'questions.type_of_employer', exact: false
        gds_select :title_question, :'questions.title', exact: false
        gds_text_input :title_other_question, :'questions.other_title'
        # Name of contact (optional)
        # For example, John Smith
        gds_text_input :contact_question, :'questions.contact.label'
        # Building name or number
        gds_text_input :building_name_question, :'questions.building_name.label', exact: false
        # Street
        gds_text_input :street_question, :'questions.street.label', exact: false
        # Town/City
        gds_text_input :town_question, :'questions.town.label', exact: false
        # County (optional)
        gds_text_input :county_question, :'questions.county.label', exact: false
        # Postcode
        gds_text_input :postcode_question, :'questions.postcode.label', exact: false
        # Document exchange (DX) number (optional)
        gds_text_input :dx_number_question, :'questions.dx_number.label', exact: false
        # Contact number (optional)
        gds_phone_input :contact_number_question, :'questions.contact_number.label', exact: false
        # Mobile number (optional)
        # If different to your primary contact numbe
        gds_phone_input :contact_mobile_number_question, :'questions.contact_mobile_number.label', exact: false
        # How would you prefer us to contact you? (optional)
        gds_radios :contact_preference_question, :'questions.contact_preference'
        gds_text_input :email_address_question, :'questions.email_address'
        gds_text_input :employment_at_site_number_question, :'questions.employment_at_site_number'

        # @!method allow_phone_or_video_attendance_question
        #   A govuk radio button component for the phone or video question
        #   @return [EtTestHelpers::Components::GovUKCollectionCheckBoxes] The site prism section
        gds_checkboxes :allow_phone_or_video_attendance_question, :'questions.allow_phone_or_video_attendance'
        # How many people does this organisation employ in Great Britain? (optional)
        gds_text_input :organisation_employ_gb_question, :'questions.organisation_employ_gb', exact: false
        # Does this organisation have more than one site in Great Britain? (optional)
        gds_radios :organisation_more_than_one_site_question, :'questions.organisation_more_than_one_site', exact: false
        # Save and continue
        gds_submit_button :continue_button, :'components.save_and_continue_button'
        def next
          continue_button.click
        end

        def switch_to_welsh
          switch_language.welsh_link.click
        end

        def switch_to_english
          switch_language.english_link.click
        end

        def has_correct_translation?
          # Respondent's Details
          expect(self).to have_header
          # Case number
          expect(self).to have_case_number_question
          # Name of individual, company or organisation
          expect(self).to have_name_question
          # Name of contact (optional)
          expect(self).to have_contact_question
          expect(contact_question).to have_hint
          # Building name or number
          expect(self).to have_building_name_question
          # Street
          expect(self).to have_street_question
          # Town/City
          expect(self).to have_town_question
          # County (optional)
          expect(self).to have_county_question
          # Postcode
          expect(self).to have_postcode_question
          # Document exchange (DX) number (optional)
          expect(self).to have_dx_number_question
          # Contact number (optional)
          expect(self).to have_contact_number_question
          # Mobile number (optional)
          expect(self).to have_contact_mobile_number_question
          expect(contact_mobile_number_question).to have_hint
          # How would you prefer us to contact you? (optional)
          expect(self).to have_contact_preference_question
          # Does this organisation have more than one site in Great Britain?
          expect(self).to have_organisation_employ_gb_question
          expect(self).to have_company_number_question
          expect(self).to have_type_of_employer_question
          expect(self).to have_title_question
          expect(self).to have_allow_phone_or_video_attendance_question
        end

        def has_correct_blank_error_messages?
          expect(self).to have_error_summary
          case_number_question.assert_error_message(t('errors.respondents_details.case_number_invalid'))
          name_question.assert_error_message(t('errors.respondents_details.company_name'))
          building_name_question.assert_error_message(t('errors.respondents_details.building_name'))
          street_question.assert_error_message(t('errors.respondents_details.street'))
          town_question.assert_error_message(t('errors.respondents_details.town'))
          postcode_question.assert_error_message(t('errors.respondents_details.postcode_blank'))
          true
        end
      end
    end
  end
end
