require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class ReturnToYourClaimPage < BasePage
        include RSpec::Matchers
        # page title
        element :header, :main_header, 'user_sessions.new.header'
        # return to your claim
        element :sub_header, :legend_header, 'user_sessions.new.subheader'
        # claim number
        # @!method claim_number
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :claim_number, :'simple_form.labels.user_session.new.reference'
        # memorable word
        # @!method memorable_word
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :memorable_word, :'simple_form.labels.user_session.new.password'

        # find my claim
        gds_submit_button :find_my_claim_button, :'helpers.submit.user_session.create'
        # don't have these details
        element :form_hint, :paragraph, 'user_sessions.new.hint_html', exact: false
        element :new_claim, :link_named, 'user_sessions.new.link'
        element :reset_memorable_word_element, :link_named, 'helpers.link.user_session.reset_memorable_word'
        section :flash_heading, '#flash-summary' do
          element :memorable_word_email_sent_flash_element, :paragraph,
                  'simple_form.labels.user_session.memorable_word.email_sent_flash_text'
          element :memorable_word_updated_flash_element, :paragraph,
                  'simple_form.labels.user_session.memorable_word.updated_flash_text'
          element :invalid, :paragraph, 'user_sessions.new.invalid'
        end

        # Support links
        section :support, 'aside[role="complementary"]' do
          element :suport_header, :support_header, 'shared.aside.gethelp_header'
          element :guide, :link_named, 'shared.aside.read_guide'
          element :contact_use, :link_named, 'shared.aside.contact_us'
        end

        def find_my_claim
          find_my_claim_button.click
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def start_a_new_claim
          new_claim.click
        end

        def reset_memorable_word
          reset_memorable_word_element.click
          ResetMemorableWordEmailInstructionsPage.new
        end

        def assert_memorable_word_email_sent
          flash_heading.memorable_word_email_sent_flash_element
          self
        end

        def assert_memorable_word_updated
          flash_heading.memorable_word_updated_flash_element
          self
        end

        def memorable_word_valid?
          expect(flash_heading).to have_invalid
        end

        def has_correct_translation?
          # header
          expect(self).to have_header
          expect(self).to have_sub_header
          # enter your details below
          claim_number.assert_valid_hint
          # find my claim
          expect(self).to have_find_my_claim_button
          # don't have these details
          expect(self).to have_form_hint
        end

        def set(user)
          data = user[0].to_h
          tap do |s|
            set_field(s, :claim_number, data)
            set_field(s, :memorable_word, data)
          end
        end

        def set_user(user)
          data = user[0].to_h
          tap do |s|
            set_field(s, :claim_number, data)
          end
        end

        private

        def set_field(s, key, data)
          s.send(key).set(data[key]) if data.key?(key)
        end
      end
    end
  end
end
