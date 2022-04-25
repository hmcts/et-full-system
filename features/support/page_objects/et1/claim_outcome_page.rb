require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class ClaimOutcomePage < BasePage
        include RSpec::Matchers
        # Claim outcome
        element :page_header, :page_title, 'claims.claim_outcome.header', exact: false

        # What do you want if your claim is successful? (optional)
        # @!method claim_outcome
        #   A govuk collection of checkboxes component for claim_outcome question
        #   @return [EtTestHelpers::Components::GovUKCollectionCheckBoxes] The site prism section
        gds_checkboxes :claim_outcome, :'simple_form.labels.claim.desired_outcomes'

        # What compensation or other outcome do you want? (optional)
        # @!method claim_outcome_other_outcome
        #   A govuk text area component wrapping the input, label, hint etc.. for a text area
        #   @return [EtTestHelpers::Components::GovUKTextArea] The site prism section
        gds_text_area :claim_outcome_other_outcome, :'simple_form.labels.claim_outcome.other_outcome'

        # Save and continue
        gds_submit_button :save_and_continue_button, t('helpers.submit.update')

        def save_and_continue
          page.scroll_to(save_and_continue_button, align: :bottom)
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
          # Claim outcome
          expect(self).to have_page_header
          # Choose your preferred outcome(s)
          expect(self).to have_claim_outcome
          # What do you want if your claim is successful? (optional)
          claim_outcome.assert_valid_hint
          claim_outcome.assert_valid_options
          expect(self).to have_claim_outcome_other_outcome
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

        def set(claim)
          return if claim.nil? || claim.preferred_outcome.nil?

          claim_outcome.set(claim.preferred_outcome)
          data = claim.to_h
          claim_outcome_other_outcome.set(data[:preferred_outcome_notes])
        end
      end
    end
  end
end
