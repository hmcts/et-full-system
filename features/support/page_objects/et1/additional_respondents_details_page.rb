require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      # The additional respondents page
      class AdditionalRespondentsDetailsPage < BasePage
        include RSpec::Matchers
        # Additional respondents
        element :page_header, :page_title, 'claims.additional_respondents.header', exact: false

        # @!method error_summary
        #   A govuk error component
        #   @return [EtTestHelpers::Components::GovUKErrorSummary] The site prism section
        gds_error_summary :error_summary, :'shared.error_notification.default_message'

        # Claims against more than one employer
        # Are you making a claim against another person or organisation?
        # @!method additional_respondents
        #   A govuk radio button component for additional_respondents question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
        gds_radios :additional_respondents, :'claims.additional_respondents.additional_respondents'

        section :respondent_2, AdditionalRespondentSection, :group_claimants, 'claims.additional_respondents.person',
                number: 2
        section :respondent_3, AdditionalRespondentSection, :group_claimants, 'claims.additional_respondents.person',
                number: 3
        section :respondent_4, AdditionalRespondentSection, :group_claimants, 'claims.additional_respondents.person',
                number: 4
        section :respondent_5, AdditionalRespondentSection, :group_claimants, 'claims.additional_respondents.person',
                number: 5
        section :respondent_6, AdditionalRespondentSection, :group_claimants, 'claims.additional_respondents.person',
                number: 6

        # Add another respondent
        gds_submit_button :add_another_respondent_button, :'claims.additional_respondents.add_fields'
        # Remove another respondent
        element :remove_another_respondent_button, :remove_multiple,
                'claims.additional_respondents.remove_resource_link'
        # Save and continue
        gds_submit_button :save_and_continue_button, t('helpers.submit.update')

        def remove_another_respondent
          remove_another_respondent_button.click
        end

        def save_and_continue
          page.execute_script 'window.scrollBy(0,10000)'
          save_and_continue_button.click
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def has_correct_translation?
          # your feedback header
          expect(feedback_notice).to have_language
          expect(feedback_notice).to have_feedback_link
          expect(feedback_notice).to have_feedback_info
          # Additional respondents
          expect(main_header).to have_page_header
          # Claims against more than one employer
          additional_respondents.assert_valid_options
          additional_respondents.assert_valid_hint
          # Respondent details
          expect(respondent_2).to have_name
          expect(respondent_2).to have_building
          expect(respondent_2).to have_street
          expect(respondent_2).to have_locality
          expect(respondent_2).to have_county
          expect(respondent_2).to have_post_code
          # Acas number
          expect(respondent_2).to have_acas_number
          # I don't have an acas number
          expect(respondent_2).to have_no_acas_number
          expect(respondent_2).to have_no_acas_number_note_one
          respondent_2.respondent_no_acas_number_reason.assert_valid_options
          # Add another respondent
          expect(self).to have_add_another_respondent
          # Save and continue
          expect(self).to have_save_and_continue_button
          # Support
          expect(support).to have_suport_header
          expect(support).to have_guide
          expect(support).to have_contact_use
          # Save your claim later
          expect(support).to have_your_claim
          # TODO: this has stopped working - why?
          # expect(support).to have_save_and_complete_later
        end

        def has_correct_blank_validation?
          expect(self).to have_error_summary
          respondent_2.name.assert_valid_error(:blank)
          respondent_2.building.assert_valid_error(:blank)
          respondent_2.street.assert_valid_error(:blank)
          respondent_2.locality.assert_valid_error(:blank)
          respondent_2.county.assert_valid_error(:blank)
          respondent_2.post_code.assert_valid_error(:blank)
          respondent_2.acas_number.assert_valid_error(:blank)
        end

        def has_correct_invalid_acas_number?
          respondent_2.acas_number.assert_valid_error(:invalid)
        end

        def has_correct_invalid_postcode?
          expect(respondent_2).to have_post_code
        end

        def set(respondents)
          return if respondents.nil? || respondents.empty?

          if respondents.length == 1
            additional_respondents.set(:no)
          else
            additional_respondents.set(:yes)
            respondents[1..-1].each_with_index do |respondent, idx|
              add_another_respondent_button.click unless idx == 0
              populate_respondent send(:"respondent_#{idx + 2}"), respondent.to_h
            end
          end
        end

        private

        def populate_respondent(section, respondent)
          set_field section, :name, respondent
          set_field section, :building, respondent
          set_field section, :street, respondent
          set_field section, :locality, respondent
          set_field section, :county, respondent
          set_field section, :post_code, respondent
          if respondent.key?(:no_acas_number_reason)
            section.no_acas_number.set(:no)
            section.respondent_no_acas_number_reason.set(respondent[:no_acas_number_reason])
          else
            section.no_acas_number.set(:yes)
            set_field section, :acas_number, respondent
          end
        end

        def set_field(s, key, data)
          s.send(key).set(data[key]) if data.key?(key)
        end
      end
    end
  end
end
