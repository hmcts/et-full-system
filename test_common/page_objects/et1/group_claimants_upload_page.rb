require_relative './base_page'
require_relative '../../../test_common/helpers/upload_helper'
module EtFullSystem
  module Test
    module Et1
      class GroupClaimantsUploadPage < BasePage
        include RSpec::Matchers
        # Group claims
        element :page_header, :page_title, 'claims.additional_claimants.header', exact: false
        # @!method error_summary
        #   A govuk error component
        #   @return [EtTestHelpers::Components::GovUKErrorSummary] The site prism section
        gds_error_summary :error_summary, :'shared.error_notification.default_message'

        # People making a claim with you
        element :people_making_claim, :legend_header, 'claims.additional_claimants.subheader'

        # @!method has_additional_claimants
        #   A govuk radio button component for has_additional_claimants question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
        gds_radios :has_additional_claimants, :'simple_form.labels.additional_claimants_upload.has_additional_claimants'

        element :manually_link, :link_named, 'claims.additional_claimants_upload.has_additional_claimants_link',
                exact: false

        # Spreadsheet for group claim
        section :group_claims, :legend_header, 'claims.additional_claimants_upload.steps_header' do
          include EtTestHelpers::Section
          # Step 1
          element :step_1, :paragraph, 'claims.additional_claimants_upload.step_one_header'
          element :download_spreadsheet_template_link, :link_named,
                  'claims.additional_claimants_upload.download_template_html', exact: false
          element :use_your_own_text, :paragraph, 'claims.additional_claimants_upload.use_your_own_text', exact: false
          element :dob_info, :paragraph, 'claims.additional_claimants_upload.dob_info'
          # Step 2
          element :step_2, :paragraph, 'claims.additional_claimants_upload.step_two_header'
          element :save_csv_format_text, :paragraph, 'claims.additional_claimants_upload.save_csv_format', exact: false
          element :how_to_save, :paragraph, 'claims.additional_claimants_upload.how_to_save'
          element :no_spaces, :paragraph, 'claims.additional_claimants_upload.no_spaces', exact: false
          # Step 3
          element :step_3, :paragraph, 'claims.additional_claimants_upload.step_three_header'
          element :file_spreadsheet_labelled, :form_labelled,
                  'simple_form.labels.additional_claimants_upload.additional_claimants_csv', exact: false

          # @!method file_upload
          #   A govuk file field component wrapping the input, label, hint etc.. for the file_upload question
          #   @return [EtTestHelpers::Components::GovUKFileDropzoneField] The site prism section
          gds_file_dropzone_upload :file_upload, :'simple_form.labels.additional_claimants_upload.additional_claimants_csv' do
            include ::EtFullSystem::Test::UploadHelper
            def set(value)
              force_remote do
                super(value)
              end
            end
          end
          # Maximum file size is 2MB
          element :upload_limit, :paragraph, 'claims.additional_claimants_upload.upload_limit', exact: false
        end
        # Save and continue
        gds_submit_button :save_and_continue_button, t('helpers.submit.update')

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def has_correct_translation_for_group_claimants?
          # your feedback header
          expect(feedback_notice).to have_language
          expect(feedback_notice).to have_feedback_link
          expect(feedback_notice).to have_feedback_info
          # Group claims
          expect(self).to have_page_header
          # people making a claim with you
          expect(self).to have_people_making_claim
          # Do you want to upload details of 6 claimants or more? (optional)
          expect(self).to have_has_additional_claimants
          # For up to 5 other claimants you can enter their details manually
          has_additional_claimants.assert_valid_hint
          has_additional_claimants.assert_valid_options
          expect(self).to have_manually_link
          # Spreadsheet for group claim
          expect(self).to have_group_claims
          expect(group_claims).to have_step_1
          expect(group_claims).to have_download_spreadsheet_template_link
          expect(group_claims).to have_use_your_own_text
          expect(group_claims).to have_dob_info
          expect(group_claims).to have_step_2
          expect(group_claims).to have_save_csv_format_text
          expect(group_claims).to have_how_to_save
          expect(group_claims).to have_no_spaces
          expect(group_claims).to have_step_3
          expect(group_claims).to have_file_spreadsheet_labelled
          expect(group_claims).to have_upload_limit
          # save and continue
          expect(self).to have_save_and_continue_button
          # Support links
          expect(support).to have_suport_header
          expect(support).to have_guide
          expect(support).to have_contact_use
          # Save your claim later
          expect(support).to have_your_claim
          # TODO: this has stopped working - why?
          # expect(support).to have_save_and_complete_later
        end

        def set(user)
          group_claims_csv = user[0].dig(:group_claims_csv)
          if group_claims_csv.present?
            has_additional_claimants.set(:yes)
            full_path = File.expand_path(File.join('test_common', 'fixtures', group_claims_csv))
            group_claims.file_upload.set(full_path)
          else
            has_additional_claimants.set(:no)
          end
        end

        def save_and_continue
          page.scroll_to(save_and_continue_button, align: :bottom)
          save_and_continue_button.click
        end
      end
    end
  end
end
