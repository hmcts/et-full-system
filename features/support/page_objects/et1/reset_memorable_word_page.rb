require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class ResetMemorableWordPage < BasePage
        include EtTestHelpers::Page

        def set_memorable_word(value)
          memorable_word.set(value)
          submit_button.submit
          ReturnToYourClaimPage.new
        end

        # @param [String] email_address
        # @return [ET1::Test::ResetMemorableWordPage]
        # Loads the memorable word page referenced in the email for a specific email address
        def from_email_for(email_address)
          email = EtFullSystem::Test::Et1ResetPasswordEmailHtml.find(email_address: email_address)
          raise Capybara::ElementNotFound, "Email not found for #{email_address}" if email.nil?

          visit email.reset_memorable_word_url
          self
        end

        # @!method memorable_word
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :memorable_word, :'claims.reset_password.new_password.label'
        # @!method submit_button
        #   A govuk submit button component...
        #   @return [EtTestHelpers::Components::GovUKSubmit] The site prism section
        gds_submit_button :submit_button, :'helpers.submit.user_session.reset_memorable_word'
      end
    end
  end
end
