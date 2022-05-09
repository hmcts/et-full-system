require_relative './base_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class AdditionalRespondentSection < BaseSection
          include RSpec::Matchers
          include EtFullSystem::Test::I18n
          section :name, :govuk_summary_list_row, :'review.additional_respondents.respondent.questions.name' do
            element :answer, :govuk_summary_list_col
          end

          section :acas_number, :govuk_summary_list_row, :'review.additional_respondents.respondent.questions.acas_number' do
            element :answer, :govuk_summary_list_col
          end

          section :address, :govuk_summary_list_row, :'review.additional_respondents.respondent.questions.address' do
            element :answer, :govuk_summary_list_col
          end

          def has_correct_translation?(respondent)
            aggregate_failures 'validating respondent' do
              expect(name).to have_answer(text: with_not_entered(respondent.name))
              expect(acas_number).to have_answer(text: with_not_entered(respondent.acas_number))
              expect(address).to have_answer(text: with_not_entered_address(respondent))
            end
            true
          end

          private

          def with_not_entered_address(respondent)
            if respondent.building.nil? && respondent.street.nil? && respondent.locality.nil? && respondent.county.nil? && respondent.post_code.nil?
              t('review.common.not_entered')
            else
              "#{respondent.building}#{respondent.street}#{respondent.locality}#{respondent.county}#{respondent.post_code}"
            end
          end
        end
      end
    end
  end
end
