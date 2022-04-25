require_relative './base_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class AdditionalInformationSection < BaseSection
          section :important_details, :govuk_summary_list_row,
                  :'review.additional_information.questions.important_details' do
            element :answer, :govuk_summary_list_col
          end

          def has_correct_translation?(claim:)
            expect(important_details).to have_answer(text: with_not_entered(claim.other_important_details))
          end
        end
      end
    end
  end
end
