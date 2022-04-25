require_relative './base_page'
module EtFullSystem
  module Test
    module Diversity
      class SexualIdentityPage < BasePage
        include RSpec::Matchers
        section :feedback_notice, '.feedback-notice' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end

        #How do you identify?
        element :header, :main_header, 'diversities.identity.header', exact: false
        # What is your sex?
        # @!method sex
        #   A govuk radio button component for sex question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
        gds_radios :sex, :'diversities.identity.sex'
        # Which of the options below best describes your sexual identity?
        # @!method sexual_identity
        #   A govuk radio button component for sexual_identity question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section

        gds_radios :sexual_identity, :'diversities.identity.sexual_identity'
        #save and continue button
        gds_submit_button :save_and_continue_button, :'helpers.submit.update'

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

        def set_for(answers)
          sex.set(answers.sex)
          sexual_identity.set(answers.sexual_identity)
          save_and_continue
        end

        def has_correct_translation?
          expect(feedback_notice).to have_language
          expect(self).to have_header
          # What is your sex? (optional)
          sex.assert_valid_options
          # Which of the options below best describes your sexual identity? (optional)
          sexual_identity.assert_valid_options
          true
        end
      end
    end
  end
end
