require_relative './base_page'
require_relative '../../helpers/upload_helper'
module EtFullSystem
  module Test
    module Et1
      class ClaimDetailsPage < BasePage
        include RSpec::Matchers
        # Claim details
        element :page_header, :page_title, 'claims.claim_details.header', exact: false

        # @!method error_summary
        #   A govuk error component
        #   @return [EtTestHelpers::Components::GovUKErrorSummary] The site prism section
        gds_error_summary :error_summary, :'shared.error_notification.default_message'
        # Describe your claim
        element :describe_your_claim, :legend_header, 'claims.claim_details.claim_details'
        # Write your claim statement below. Include the background, dates and people involved.
        element :describe_your_claim_info, :paragraph, 'claims.claim_details.claim_details_html', exact: false
        # More about writing your claim statement.
        element :about_claim_info, :link_named, 'claims.claim_details.claim_details_hint', exact: false
        # Or upload it as a separate document
        element :upload_document, :summary_text, 'claims.claim_details.claim_details_upload'
        # @!method file_upload
        #   A govuk file field component wrapping the input, label, hint etc.. for the file_upload question
        #   @return [EtTestHelpers::Components::GovUKFileDropzoneField] The site prism section
        gds_file_dropzone_upload :file_upload, :'simple_form.labels.claim_details.claim_details_rtf'

        # @!method claim_details_claim_details
        #   A govuk text area component wrapping the input, label, hint etc.. for a text area
        #   @return [EtTestHelpers::Components::GovUKTextArea] The site prism section
        gds_text_area :claim_details_claim_details, :'claims.claim_details.claim_details' do
          element :claim_details_claim_details_hint, :form_hint, 'claims.claim_details.claim_details_hint_html'
        end

        # Similar claims
        # @!method other_claimants_fieldset
        #   A govuk fieldset component
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_fieldset :other_claimants_fieldset, :'claims.claim_details.similar_claims' do
          include EtTestHelpers::Section
          # Do you know of any other claimants (not already listed) making similar claims against the same employer? (optional)
          # @!method other_known_claimants
          #   A govuk radio button component for other_known_claimants question
          #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
          gds_radios :other_known_claimants, :'simple_form.labels.claim_details.other_known_claimants'

          # @!method other_known_claimant_names
          #   A govuk text area component for the 'You can add the names of other people here. (optional)' question
          #   @return [EtTestHelpers::Components::GovUKTextArea] The site prism section
          gds_text_area :other_known_claimant_names, :'simple_form.labels.claim_details.other_known_claimant_names' do
            element :claim_details_other_known_claimant_names_hint, :form_hint,
                    'simple_form.hints.claim_details.other_known_claimants', exact: false
          end
        end
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

        def has_mandatory_error_message?
          expect(self).to have_error_summary
          expect(claim_details_claim_details).to have_error(text: t('activemodel.errors.models.claim_details.attributes.claim_details.blank'))
        end

        def has_correct_translation?
          # your feedback header
          expect(feedback_notice).to have_language
          expect(feedback_notice).to have_feedback_link
          expect(feedback_notice).to have_feedback_info
          # Claim details
          expect(self).to have_page_header
          # Describe your claim
          expect(self).to have_describe_your_claim_info
          expect(self).to have_about_claim_info
          expect(self).to have_upload_document
          expect(self).to have_file_upload
          expect(file_upload).to have_hint(text: t('simple_form.hints.claim_details.claim_details_rtf'))
          # Limit is 2500 characters. (2500 characters remaining)
          other_claimants_fieldset.tap do |f|
            f.other_known_claimants.assert_valid_options
            f.other_known_claimants.assert_valid_hint
            # You can add the names of other people here. (optional)
            expect(f.other_known_claimant_names).to have_hint
          end
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
          data = claim.to_h
          return if claim.nil?

          if data.key?(:rtf_file)
            upload_document.click
            full_path = File.expand_path(File.join('features', 'support', 'fixtures', data[:rtf_file]))
            file_upload.set(full_path)
          end
          claim_details_claim_details.set(data[:description])
          other_claimants_fieldset.other_known_claimants.set(data[:similar_claims])
          if data[:similar_claims].to_s.split('.').last == 'yes'
            other_claimants_fieldset.other_known_claimant_names.set(data[:other_claimant_names])
          end
        end
      end
    end
  end
end
