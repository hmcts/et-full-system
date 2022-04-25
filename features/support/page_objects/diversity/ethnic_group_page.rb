require_relative './base_page'
module EtFullSystem
  module Test
    module Diversity
      class EthnicGroupPage < BasePage
        include RSpec::Matchers
        section :feedback_notice, '.feedback-notice' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        section :main_content, '.container' do
          include EtTestHelpers::Section
          # What is your ethnic group?
          gds_radios :ethnicity_group, :'diversities.ethnicity.ethnicity_group'

          # The groups below are in non visual fieldsets to help us differentiate
          section :white_fieldset, '*[data-subgroup="white"]' do
            include EtTestHelpers::Section
            # What is your ethnic type? (optional)
            # @!method selection
            #   A govuk radio button component for ethnicity_subgroup question
            #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
            gds_radios :white_subgroup, :'diversities.ethnicity.ethnicity_subgroup.white'
          end

          section :mixed_fieldset, '*[data-subgroup="mixed-multiple-ethnic-groups"]' do
            include EtTestHelpers::Section
            # What is your ethnic type? (optional)
            # @!method selection
            #   A govuk radio button component for ethnicity_subgroup question
            #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
            gds_radios :mixed_subgroup, :'diversities.ethnicity.ethnicity_subgroup.mixed-multiple-ethnic-groups'
          end

          section :asian_fieldset, '*[data-subgroup="asian-asian-british"]' do
            include EtTestHelpers::Section
            # What is your ethnic type? (optional)
            # @!method selection
            #   A govuk radio button component for ethnicity_subgroup question
            #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
            gds_radios :asian_subgroup, :'diversities.ethnicity.ethnicity_subgroup.asian-asian-british'
          end

          section :black_fieldset, '*[data-subgroup="black-african-caribbean-black-british"]' do
            include EtTestHelpers::Section
            # What is your ethnic type? (optional)
            # @!method selection
            #   A govuk radio button component for ethnicity_subgroup question
            #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
            gds_radios :black_subgroup, :'diversities.ethnicity.ethnicity_subgroup.black-african-caribbean-black-british'
          end

          section :other_fieldset, '*[data-subgroup="other-ethnic-group"]' do
            include EtTestHelpers::Section
            # What is your ethnic type? (optional)
            # @!method selection
            #   A govuk radio button component for ethnicity_subgroup question
            #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
            gds_radios :other_subgroup, :'diversities.ethnicity.ethnicity_subgroup.any-other-mixed-multiple-ethnic-background'
          end
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
          if answers[:ethnicity]
            main_content.ethnicity_group.set(answers[:ethnicity])
            ethnicity_subgroup_short = answers[:ethnicity].to_s.split('.').last.split('-').first
            subgroup_method = :"#{ethnicity_subgroup_short}_subgroup"
            fieldset_method = :"#{ethnicity_subgroup_short}_fieldset"
            if main_content.respond_to?(fieldset_method)
              main_content.send(fieldset_method).send(subgroup_method).set(answers[:ethnicity_subgroup])
            end
          end
          save_and_continue
        end

        def has_correct_translation?
          expect(feedback_notice).to have_language
          main_content.ethnicity_group.assert_valid_options
          main_content.ethnicity_group.set :'diversities.ethnicity.ethnicity_group.options.white'
          main_content.white_fieldset.white_subgroup.assert_valid_options
          main_content.ethnicity_group.set :'diversities.ethnicity.ethnicity_group.options.mixed-multiple-ethnic-groups'
          main_content.mixed_fieldset.mixed_subgroup.assert_valid_options
          main_content.ethnicity_group.set :'diversities.ethnicity.ethnicity_group.options.asian-asian-british'
          main_content.asian_fieldset.asian_subgroup.assert_valid_options
          main_content.ethnicity_group.set :'diversities.ethnicity.ethnicity_group.options.black-african-caribbean-black-british'
          main_content.black_fieldset.black_subgroup.assert_valid_options
          main_content.ethnicity_group.set :'diversities.ethnicity.ethnicity_group.options.other-ethnic-group'
          main_content.other_fieldset.other_subgroup.assert_valid_options
          true
        end
      end
    end
  end
end
