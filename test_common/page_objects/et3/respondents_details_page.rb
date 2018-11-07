require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class RespondentsDetailsPage < BasePage
        set_url '/respond/respondents_details'
        element :error_header, :error_titled, 'errors.header', exact: true
        section :case_number_question, :question_labelled, 'questions.case_number.label', exact: false do
          element :field, :css, "input"
          element :error_invalid, :exact_error_text, 'errors.messages.invalid', exact: false
          def set(*args); field.set(*args); end
        end
        section :name_question, :question_labelled, 'questions.name.label', exact: false do
          element :field, :css, "input"
          element :error_blank, :exact_error_text, 'errors.messages.blank', exact: false
          def set(*args); field.set(*args); end
        end
        section :contact_question, :question_labelled, 'questions.contact.label', exact: false do
          element :field, :css, "input"
          element :error_contains_numbers, :exact_error_text, 'errors.messages.contains_numbers', exact: false
          element :error_contains_no_spaces, :exact_error_text, 'errors.messages.contains_no_spaces', exact: false
          def set(*args); field.set(*args); end
        end
        section :building_name_question, :question_labelled, 'questions.building_name.label', exact: false do
          element :field, :css, "input"
          element :error_blank, :exact_error_text, 'errors.messages.blank', exact: false
          def set(*args); field.set(*args); end
        end
        section :street_question, :question_labelled, 'questions.street.label', exact: false do
          element :field, :css, "input"
          element :error_blank, :exact_error_text, 'errors.messages.blank', exact: false
          def set(*args); field.set(*args); end
        end
        section :town_question, :question_labelled, 'questions.town.label', exact: false do
          element :field, :css, "input"
          element :error_blank, :exact_error_text, 'errors.messages.blank', exact: false
          def set(*args); field.set(*args); end
        end
        section :county_question, :question_labelled, 'questions.county.label', exact: false do
          element :field, :css, "input"
          def set(*args); field.set(*args); end
        end
        section :postcode_question, :question_labelled, 'questions.postcode.label', exact: false do
          element :field, :css, "input"
          element :error_blank, :exact_error_text, 'errors.messages.blank', exact: false
          element :error_invalid, :exact_error_text, 'errors.messages.invalid', exact: false
          def set(*args); field.set(*args); end
        end
        section :dx_number_question, :question_labelled, 'questions.dx_number.label', exact: false do
          element :field, :css, "input"
          def set(*args); field.set(*args); end
        end
        section :contact_number_question, :question_labelled, 'questions.contact_number.label', exact: false do
          element :field, :css, "input"
          element :error_invalid, :exact_error_text, 'errors.messages.invalid', exact: false
          def set(*args); field.set(*args); end
        end
        section :contact_mobile_number_question, :question_labelled, 'questions.contact_mobile_number.label', exact: false do
          element :field, :css, "input"
          element :error_invalid, :exact_error_text, 'errors.messages.invalid', exact: false
          def set(*args); field.set(*args); end
        end
        section :contact_preference_question, :single_choice_option, 'questions.contact_preference.label', exact: false do |q|
          section :select_email, :gds_multiple_choice_option, 'questions.contact_preference.email.label' do
            element :selector, :css, 'input[type="radio"]'
            def set(*args); selector.set(*args); end
          end
          section :select_post, :gds_multiple_choice_option, 'questions.contact_preference.post.label' do
            element :selector, :css, 'input[type="radio"]'
            def set(*args); selector.set(*args); end
          end
          section :select_fax, :gds_multiple_choice_option, 'questions.contact_preference.fax.label' do
            element :selector, :css, 'input[type="radio"]'
            def set(*args); selector.set(*args); end
          end
          section :preference_email, :inputtext_labelled, 'questions.contact_preference.email.input_label' do
            def set(*args); root_element.set(*args); end
          end
          section :preference_fax, :inputtext_labelled, 'questions.contact_preference.fax.input_label' do
            def set(*args); root_element.set(*args); end
          end
          element :error_invalid_email, :exact_error_text, 'errors.messages.invalid', exact: false
          element :error_invalid_fax, :exact_error_text, 'errors.messages.invalid', exact: false
          def set_for(user)
            case user.contact_preference
              when "email"
                select_email.set(true)
                preference_email.set(user.email_address)
              when "post"
                select_post.set(true)
              when "fax"
                select_fax.set(true)
                preference_fax.set(user.fax_number)
            end
          end
        end
        section :organisation_employ_gb_question, :question_labelled, 'questions.organisation_employ_gb.label', exact: false do
          element :field, :css, "input"
          element :error_blank, :exact_error_text, 'errors.messages.blank', exact: false
          element :error_not_a_number, :exact_error_text, 'errors.messages.not_a_number', exact: false
          def set(*args); field.set(*args); end
        end
        section :organisation_more_than_one_site_question, :single_choice_option, 'questions.organisation_more_than_one_site.label', exact: false do |q|
          element :inclusion, :exact_error_text, 'errors.custom.organisation_more_than_one_site.inclusion', exact: false
          section :yes, :gds_multiple_choice_option, 'questions.organisation_more_than_one_site.yes.label', exact: false do
            element :selector, :css, 'input'
            
            def set(*args); selector.set(*args); end
          end
          section :no, :gds_multiple_choice_option, 'questions.organisation_more_than_one_site.no.label', exact: false do
            element :selector, :css, 'input'
            def set(*args); selector.set(*args); end
          end
          section :employment_at_site_number, :inputtext_labelled, 'questions.organisation_more_than_one_site.employment_at_site_number.label', exact: false do
            def set(*args); root_element.set(*args); end
          end
          element :error_not_a_number, :exact_error_text, 'errors.messages.not_a_number', exact: false
          def set_for(user)
            if user.organisation_more_than_one_site == 'Yes'
              yes.set(true)
              employment_at_site_number.set(user.employment_at_site_number)
            else 
              no.set(true)
            end
          end
        end
        element :continue_button, :button, "Save and continue"
        def next
          continue_button.click
        end
      end
    end
  end
end
