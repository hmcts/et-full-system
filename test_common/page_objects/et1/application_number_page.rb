require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class ApplicationNumberPage < BasePage
        include RSpec::Matchers
        #your feedback header
        section :feedback_notice, '.feedback-notice' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
          element :feedback_link, :paragraph, 'shared.feedback_link.feedback_statement_html'
        end
        #page and main header
        section :main_header, '.main-header' do
          element :page_header, :page_title, 'claims.application_number.header'
        end
        section :main_content, '#content .main-section .main-content' do
          element :claim_number_text, :paragraph, 'claims.application_number.application_number'
          element :claims_number, '.callout-reference .number'
          element :claims_intro_text, :paragraph, 'claims.application_number.intro_text'
          #email address
          section :email_label, :question_labelled, 'simple_form.labels.application_number.email_address', exact: false do
            element :field, :css, "input"
            delegate :set, to: :field
          end
          #create your memorable word
          section :memorable_word_label, :question_labelled, 'simple_form.labels.application_number.password', exact: false do
            element :field, :css, "input"
            delegate :set, to: :field
          end
          element :example_word, :paragraph, 'simple_form.hints.application_number.password'
          #print this page
          element :print_link, :link_named, 'user_sessions.reminder.print_link'
          element :print_copy, :paragraph, 'claims.application_number.print_copy', exact: false
          #save and continue button
          element :save_and_continue, :submit_text, 'helpers.submit.update'
        end
        #Support links
        section :support, 'aside[role="complementary"]' do
          element :suport_header, :support_header, 'shared.aside.gethelp_header'
          element :guide, :link_named, 'shared.aside.read_guide'
          element :contact_use, :link_named, 'shared.aside.contact_us'
        end

        def switch_language
          feedback_notice.language.click
        end

        def save_and_continue
          main_content.save_and_continue.click
        end

        def has_correct_translation?
          #saving your claim heading
          expect(main_header).to have_page_header
          #your claim number
          expect(main_content).to have_claim_number_text
          #claim intro
          expect(main_content).to have_claims_intro_text
          #email address
          expect(main_content).to have_email_label
          #memorable
          expect(main_content).to have_memorable_word_label
          #print this page
          expect(main_content).to have_print_link
          expect(main_content).to have_print_copy
          #save and continue button
          expect(main_content).to have_example_word
          #Support links
          expect(support).to have_suport_header
          expect(support).to have_guide
          expect(support).to have_contact_use
        end


        def set(data)
          main_content.email_label.set(data.dig(:email_address))
          main_content.memorable_word_label.set(data.dig(:memorable_word))
        end
      end
    end
  end
end