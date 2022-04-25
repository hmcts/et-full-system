require_relative './base_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class RespondentSection < BaseSection
          section :name, :govuk_summary_list_row, :'review.respondent.questions.name' do
            element :answer, :govuk_summary_list_col
          end
          section :address, :govuk_summary_list_row, :'review.respondent.questions.address' do
            element :answer, :govuk_summary_list_col
          end
          section :phone, :govuk_summary_list_row, :'review.respondent.questions.phone' do
            element :answer, :govuk_summary_list_col
          end
          section :acas_number, :govuk_summary_list_row, :'review.respondent.questions.acas_number' do
            element :answer, :govuk_summary_list_col
          end
          section :work_address, :govuk_summary_list_row, :'review.respondent.questions.work_address' do
            element :answer, :govuk_summary_list_col
          end

          def has_correct_translation?(respondent:)
            aggregate_failures 'validating respondent' do
              expect(name).to have_answer(text: with_not_entered(respondent.name))
              expect(acas_number).to have_answer(text: with_not_entered(respondent.acas_number))
              expect(address).to have_answer(text: with_not_entered_address(respondent))
              expect(phone).to have_answer(text: with_not_entered(respondent.telephone_number))
              expect(work_address).to have_answer(text: with_not_entered_work_address(respondent))
            end
            true
          end

          private

          def with_not_entered_address(obj)
            if obj.nil? || (obj.building.nil? && obj.street.nil? && obj.locality.nil? && obj.county.nil? && obj.post_code.nil?)
              t('review.common.not_entered')
            else
              "#{obj.building}#{obj.street}#{obj.locality}#{obj.county}#{obj.post_code}"
            end
          end

          def with_not_entered_work_address(obj)
            if obj.nil? || (obj.work_building.nil? && obj.work_street.nil? && obj.work_locality.nil? && obj.work_county.nil? && obj.work_post_code.nil?)
              t('review.common.not_entered')
            else
              "#{obj.work_building}#{obj.work_street}#{obj.work_locality}#{obj.work_county}#{obj.work_post_code}"
            end
          end
        end
      end
    end
  end
end
