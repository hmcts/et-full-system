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
          element :header, :main_header, 'ethnicity.header'

          section :white, :form_labelled, 'ethnicity.white' do
            element :field, 'input'

            delegate :set, to: :field
          end

          section :mixed, :form_labelled, 'ethnicity.mixed-multiple-ethnic-groups' do
            element :field, 'input'

            delegate :set, to: :field
          end

          section :asian, :form_labelled, 'ethnicity.asian-asian-british' do
            element :field, 'input'

            delegate :set, to: :field
          end

          section :black, :form_labelled, 'ethnicity.black-african-caribbean-black-british' do
            element :field, 'input'

            delegate :set, to: :field
          end

          section :other, :form_labelled, 'ethnicity.other-ethnic-group' do
            element :field, 'input'

            delegate :set, to: :field
          end

          section :prefer_not_to_say, :form_labelled, 'ethnicity.prefer_not_to_say' do
            element :field, 'input'

            delegate :set, to: :field
          end

          section :white_subgroup, :diversity_ethnicity_group_containing, 'ethnicity_subgroup.english-welsh-scottish-northern-irish-british' do
            element :header, 'label', 'ethnicity_subgroup.label'

            section :english, :form_labelled, 'ethnicity_subgroup.english-welsh-scottish-northern-irish-british' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :irish, :form_labelled, 'ethnicity_subgroup.irish' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :gypsy, :form_labelled, 'ethnicity_subgroup.gypsy-or-irish-traveller' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :other_white, :form_labelled, 'ethnicity_subgroup.any-other-white-background' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :none_of_the_above, :form_labelled, 'ethnicity_subgroup.none-of-the-above' do
              element :field, 'input'

              delegate :set, to: :field
            end
          end

          section :mixed_subgroup, :diversity_ethnicity_group_containing, 'ethnicity_subgroup.white-and-black-caribbean' do
            element :header, 'label', 'ethnicity_subgroup.label'

            section :white_and_black_caribbean, :form_labelled, 'ethnicity_subgroup.white-and-black-caribbean' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :white_and_black_african, :form_labelled, 'ethnicity_subgroup.white-and-black-african' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :white_and_asian, :form_labelled, 'ethnicity_subgroup.white-and-asian' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :mixed_background, :form_labelled, 'ethnicity_subgroup.any-other-mixed-multiple-ethnic-background' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :none_of_the_above, :form_labelled, 'ethnicity_subgroup.none-of-the-above' do
              element :field, 'input'

              delegate :set, to: :field
            end
          end

          section :asian_subgroup, :diversity_ethnicity_group_containing, 'ethnicity_subgroup.indian' do
            element :header, 'label', 'ethnicity_subgroup.label'

            section :indian, :form_labelled, 'ethnicity_subgroup.indian' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :pakistani, :form_labelled, 'ethnicity_subgroup.pakistani' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :bangladeshi, :form_labelled, 'ethnicity_subgroup.bangladeshi' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :chinese, :form_labelled, 'ethnicity_subgroup.chinese' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :other_asian, :form_labelled, 'ethnicity_subgroup.any-other-asian-background' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :none_of_the_above, :form_labelled, 'ethnicity_subgroup.none-of-the-above' do
              element :field, 'input'

              delegate :set, to: :field
            end
          end

          section :black_subgroup, :diversity_ethnicity_group_containing, 'ethnicity_subgroup.african' do
            element :header, 'label', 'ethnicity_subgroup.label'

            section :african, :form_labelled, 'ethnicity_subgroup.african' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :caribbean, :form_labelled, 'ethnicity_subgroup.caribbean' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :other_black, :form_labelled, 'ethnicity_subgroup.any-other-black-african-caribbean-background' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :none_of_the_above, :form_labelled, 'ethnicity_subgroup.none-of-the-above' do
              element :field, 'input'

              delegate :set, to: :field
            end
          end

          section :other_subgroup, :diversity_ethnicity_group_containing, 'ethnicity_subgroup.arab' do
            element :header, 'label', 'ethnicity_subgroup.label'

            section :arab, :form_labelled, 'ethnicity_subgroup.arab' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :other_ethnic_group, :form_labelled, 'ethnicity_subgroup.any-other-ethnic-group' do
              element :field, 'input'

              delegate :set, to: :field
            end

            section :none_of_the_above, :form_labelled, 'ethnicity_subgroup.none-of-the-above' do
              element :field, 'input'

              delegate :set, to: :field
            end
          end

          element :save_and_continue_button, 'input[value="Save and continue"]'
        end

        def save_and_continue
          main_content.save_and_continue_button.click
        end

        def set_for(answers)
          set_for_optional(answers, :ethnicity, 'diversities_ethnicity[ethnicity]')
          set_for_optional(answers, :ethnicity_subgroup, 'diversities_ethnicity[ethnicity_subgroup]')
          save_and_continue
        end

        def has_correct_translation?
          expect(feedback_notice).to have_language

          expect(main_content).to have_header

          expect(main_content).to have_white
          expect(main_content).to have_mixed
          expect(main_content).to have_asian
          expect(main_content).to have_black
          expect(main_content).to have_other
          expect(main_content).to have_prefer_not_to_say

          expect(main_content.white_subgroup).to have_english
          expect(main_content.white_subgroup).to have_irish
          expect(main_content.white_subgroup).to have_gypsy
          expect(main_content.white_subgroup).to have_other_white
          expect(main_content.white_subgroup).to have_none_of_the_above

          expect(main_content.mixed_subgroup).to have_white_and_black_caribbean
          expect(main_content.mixed_subgroup).to have_white_and_black_african
          expect(main_content.mixed_subgroup).to have_white_and_asian
          expect(main_content.mixed_subgroup).to have_mixed_background
          expect(main_content.mixed_subgroup).to have_none_of_the_above

          expect(main_content.asian_subgroup).to have_indian
          expect(main_content.asian_subgroup).to have_pakistani
          expect(main_content.asian_subgroup).to have_bangladeshi
          expect(main_content.asian_subgroup).to have_chinese
          expect(main_content.asian_subgroup).to have_other_asian
          expect(main_content.asian_subgroup).to have_none_of_the_above

          expect(main_content.black_subgroup).to have_african
          expect(main_content.black_subgroup).to have_caribbean
          expect(main_content.black_subgroup).to have_other_black
          expect(main_content.black_subgroup).to have_none_of_the_above

          expect(main_content.other_subgroup).to have_arab
          expect(main_content.other_subgroup).to have_other_ethnic_group
          expect(main_content.other_subgroup).to have_none_of_the_above
        end

        private

        def set_for_optional(answers, key, name)
          data = answers.to_h
          if data[key] != nil
            choose(data[key], name: name)
          end
        end
      end
    end
  end
end