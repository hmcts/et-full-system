require_relative './base_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class ClaimTypeSection < BaseSection
          section :send_to_whistleblowing_body, :govuk_summary_list_row,
                  :'review.claim_type.questions.send_to_whistleblowing_body' do
            element :answer, :govuk_summary_list_col
          end
          section :whistleblowing, :govuk_summary_list_row, :'review.claim_type.questions.whistleblowing' do
            element :answer, :govuk_summary_list_col
          end
          section :types, :govuk_summary_list_row, :'review.claim_type.questions.types.title' do
            include ::EtFullSystem::Test::I18n
            include RSpec::Matchers
            element :answer, :govuk_summary_list_col

            def has_answer_for?(claim)
              claim_types = claim.claim_types
              if claim_types.nil? || (claim_types.unfair_dismissal + claim_types.discrimination + claim_types.pay + claim_types.other).empty?
                raise 'claim types must always exist - the application should not let you get this far'
              else
                # Other type of claim is never shown as a claim type
                aggregate_failures 'validating claim types' do
                  claim_types.discrimination.each do |type|
                    expect(self).to have_answer(text: t("review.claim_type.questions.types.options.discrimination.#{type}"))
                  end
                  claim_types.pay do |type|
                    expect(self).to have_answer(text: t("review.claim_type.questions.types.options.pay.#{type}"))
                  end
                end
              end

              true
            end
          end

          def has_correct_translation?(claim:)
            aggregate_failures 'validating claim type section' do
              expect(send_to_whistleblowing_body).to have_answer(text: with_not_entered(convert_yes_no(claim.send_to_relevant_person)))
              expect(whistleblowing).to have_answer(text: with_not_entered(convert_yes_no(claim.whistleblowing_claim)))
              expect(types).to have_answer_for(claim)
            end
            true
          end
        end
      end
    end
  end
end
