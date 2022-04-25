require_relative './base_page'
module EtFullSystem
  module Test
    module Diversity
      class ClaimTypePage < BasePage
        include RSpec::Matchers
        section :feedback_notice, '.feedback-notice' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        section :main_content, '.container' do
          include EtTestHelpers::Section
          element :header, :main_header, :'diversities.claim_type.header'
          # What is the type of your claim?
          gds_radios :claim_type, :'diversities.claim_type.claim_type'
          # save and continue button
          gds_submit_button :save_and_continue, :'helpers.submit.update'
        end

        def save_and_continue
          page.scroll_to(main_content.save_and_continue, align: :bottom)
          main_content.save_and_continue.click
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def set_for(answers)
          data = answers.to_h
          main_content.claim_type.set(data[:claim_type]) unless data[:claim_type].nil?
          save_and_continue
        end

        def has_correct_translation?
          expect(feedback_notice).to have_language
          expect(main_content).to have_header
          main_content.claim_type.assert_valid_options
          main_content.claim_type.assert_valid_hint
          true
        end
      end
    end
  end
end
