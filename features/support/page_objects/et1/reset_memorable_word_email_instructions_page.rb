require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class ResetMemorableWordEmailInstructionsPage < BasePage
        include EtTestHelpers::Page

        def using(email_address:, claim_number: nil)
          fieldset.email_address.set(email_address)
          fieldset.claim_number.set(claim_number) unless claim_number.nil?
          fieldset.submit_button.submit
          ReturnToYourClaimPage.new
        end

        def submit
          fieldset.submit_button.submit
        end

        def valid?
          expect(self).to have_error_summary
        end

        section :fieldset, 'fieldset' do
          include EtTestHelpers::Section
          # @!method email_address
          #   A govuk text field component wrapping the input, label, hint etc..
          #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
          gds_text_input :email_address, :'claims.reset_password.email_address.label'
          # @!method claim_number
          #   A govuk text field component wrapping the input, label, hint etc..
          #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
          gds_text_input :claim_number, :'claims.reset_password.claim_number.label'
          # @!method submit_button
          #   A govuk submit button component...
          #   @return [EtTestHelpers::Components::GovUKSubmit] The site prism section
          gds_submit_button :submit_button, :'helpers.submit.user_session.reset_memorable_word'
        end
        # @!method error_summary
        #   A govuk error component
        #   @return [EtTestHelpers::Components::GovUKErrorSummary] The site prism section
        gds_error_summary :error_summary, :'shared.error_notification.default_message'
      end
    end
  end
end
