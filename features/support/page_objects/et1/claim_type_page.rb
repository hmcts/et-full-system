require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class ClaimTypePage < BasePage
        include RSpec::Matchers
        # About the claim
        element :page_header, :page_title, 'claims.claim_type.header', exact: false
        # @!method error_message
        #   A govuk error component
        #   @return [EtTestHelpers::Components::GovUKErrorSummary] The site prism section
        gds_error_summary :error_message, :'shared.error_notification.default_message' do
          element :error_summary, :content_header, 'shared.error_notification.error_summary', exact: false
          element :default_message, :li, 'activemodel.errors.models.claim_type.attributes.blank', exact: false
        end
        # What your claim is about
        element :about_claim, :content_header, 'claims.claim_type.claim_type'
        # Select at least one of the claim types below
        element :about_claim_info, :paragraph, 'claims.claim_type.claim_type_label'
        # Unfair dismissal
        gds_checkboxes :unfair_dismissal, :'claims.claim_type.unfair_dismissal' do
          element :unfair_dismissal_info, :paragraph, 'claims.claim_type.unfair_dismissal_summary_detail',
                  exact: false
        end
        # Discrimination
        gds_checkboxes :discrimination, :'claims.claim_type.discrimination'
        # Pay
        gds_checkboxes :pay, :'claims.claim_type.pay'
        # Other type of claim (not shown above)
        # @!method other_type_of_claim
        # A govuk collection of checkboxes component for other_type_of_claim question
        # @return [EtTestHelpers::Components::GovUKCollectionCheckBoxes] The site prism section
        gds_checkboxes :other_type_of_claim, :'claims.claim_type.other_type'

        # Give a very short description of your claim; you will have the opportunity to add more detail on the next page
        # @!method claim_type_other_claim_details
        #   A govuk text area component wrapping the input, label, hint etc.. for a text area
        #   @return [EtTestHelpers::Components::GovUKTextArea] The site prism section
        gds_text_area :claim_type_other_claim_details, :'simple_form.labels.claim_type.other_claim_details'

        # Whistleblowing claim
        section :whistleblowing_claim, :legend_header, 'claims.claim_type.whistleblowing' do
          include EtTestHelpers::Section
          # @!method is_whistleblowing
          #   A govuk radio button component for is_whistleblowing question
          #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
          gds_radios :is_whistleblowing, :'simple_form.labels.claim.is_whistleblowing'

          def set(value)
            is_whistleblowing.set(value)
          end
        end

        # Do you want us to send a copy of your claim to the relevant person or body that deals with whistleblowing?
        # @!method send_to_relevant_person
        #   A govuk radio button component for send_to_relevant_person question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
        gds_radios :send_to_relevant_person, :'simple_form.labels.claim_type.send_claim_to_whistleblowing_entity'

        # Save and continue
        gds_submit_button :save_and_continue_button, t('helpers.submit.update')

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
          # About the claim
          expect(self).to have_page_header
          # What your claim is about
          expect(self).to have_about_claim
          # Select at least one of the claim types below
          expect(self).to have_about_claim_info
          # unfair_dismissal
          unfair_dismissal.assert_valid_options
          unfair_dismissal.assert_valid_hint
          expect(unfair_dismissal).to have_unfair_dismissal_info
          # Discrimination
          discrimination.assert_valid_options
          # Pay
          pay.assert_valid_options
          # Other type of cliam (not shown above)
          other_type_of_claim.assert_valid_hint
          other_type_of_claim.assert_valid_options
          # Give a very short description of your claim
          claim_type_other_claim_details.assert_valid_hint
          # Whistleblowing claim
          expect(whistleblowing_claim).to have_is_whistleblowing
          whistleblowing_claim.is_whistleblowing.assert_valid_hint
          whistleblowing_claim.is_whistleblowing.assert_valid_options
          # whistleblowing_entity
          send_to_relevant_person.assert_valid_options
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

        def has_missing_claim_type_error_message?
          expect(error_message).to have_default_message
        end

        def save_and_continue
          page.scroll_to(save_and_continue_button, align: :bottom)
          save_and_continue_button.click
        end

        def set(claim)
          return if claim.nil? || claim.claim_types.nil?

          unfair_dismissal.set(claim.claim_types.unfair_dismissal)
          pay.set(claim.claim_types.pay)
          discrimination.set(claim.claim_types.discrimination)
          other_type_of_claim.set(claim.claim_types.other)

          data = claim.claim_types.to_h
          unless data[:other_type_of_claim_details].nil?
            claim_type_other_claim_details.set(data[:other_type_of_claim_details])
          end
          whistleblowing_claim.is_whistleblowing.set(data[:whistleblowing_claim])
          set_field self, :send_to_relevant_person, data
        end

        private

        def set_field(s, key, data)
          s.send(key).set(data[key]) if data.key?(key)
        end
      end
    end
  end
end
