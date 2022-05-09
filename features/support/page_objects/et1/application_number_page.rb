require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class ApplicationNumberPage < BasePage
        include EtTestHelpers::Page
        include RSpec::Matchers

        #page and main header
        element :page_header, :page_title, 'claims.application_number.header'

        section(:claim_number_notification, :xpath, XPath.generate { |x| x.css('.govuk-notification-banner')[x.child(:div)[x.attr(:class).contains_word('govuk-notification-banner__header') & x.string.n.equals(t('claims.application_number.application_number'))]] }) do
          element :claims_number, '.number'
        end
        # @!method email_question
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :email_question, :'simple_form.labels.application_number.email_address', exact: false
        # @!method memorable_word_question
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :memorable_word_question, :'simple_form.labels.application_number.password'


        element :claims_intro_text, :paragraph, 'claims.application_number.intro_text'

        # @!method email_question
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :email_question, :'simple_form.labels.application_number.email_address', exact: false
        # @!method memorable_word_question
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :memorable_word_question, :'simple_form.labels.application_number.password'

        element :example_word, '#save-and-return-user-password-hint'

        #print this page
        element :print_link, :govuk_link, :'user_sessions.reminder.print_link'
        element :print_copy, :paragraph, 'claims.application_number.print_copy', exact: false

        # @!method save_and_continue_button
        #   A govuk submit button component...
        #   @return [EtTestHelpers::Components::GovUKSubmit] The site prism section
        gds_submit_button :save_and_continue_button, :'helpers.submit.update'

        def switch_language
          feedback_notice.language.click
        end

        def save_and_continue
          save_and_continue_button.submit
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def has_correct_translation?
          #saving your claim heading
          expect(self).to have_page_header
          #your claim number
          expect(self).to have_claim_number_notification
          #claim intro
          expect(self).to have_claims_intro_text
          #email address
          expect(self).to have_email_question
          #memorable
          expect(self).to have_memorable_word_question
          #print this page
          expect(self).to have_print_link
          expect(self).to have_print_copy
          #save and continue button
          expect(self).to have_example_word
          #Support links
          expect(support).to have_suport_header
          expect(support).to have_guide
          expect(support).to have_contact_use
        end


        def set(data)
          main_content.email_label.set(data[0].dig(:email_address))
          main_content.memorable_word_label.set(data[0].dig(:memorable_word))
        end

        # Registers the user for a save and return
        def register(data)
          email_question.set(data[0].dig(:email_address))
          memorable_word_question.set(data[0].dig(:memorable_word))
          save_and_continue_button.submit
        end
      end
    end
  end
end
