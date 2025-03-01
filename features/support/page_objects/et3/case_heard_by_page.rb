require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class CaseHeardByPage < BasePage
        def fill_in_all(respondent:)
          fill_in_case_heard_by(respondent:)
          self
        end

        # Fills in the claim data
        # @param [Response] response The response
        def fill_in_case_heard_by(respondent:)
          case_heard_by_preference_question.set(respondent.case_heard_by_preference)
          return unless respondent.case_heard_by_preference.to_s.split('.').last.in?(%w[judge panel])

          case_heard_by_preference_reason_question.set(respondent.case_heard_by_preference_reason)
        end

        # Clicks the save and continue button
        def save_and_continue
          save_and_continue_button.submit
        end

        # @param [Hash] error_messages A list of error messages keyed by the question name (ignoring groups)
        def assert_error_messages(error_messages)
          aggregate_failures 'validating error messages' do
            error_messages.each_pair do |question_prefix, expected_message|
              question = :"#{question_prefix}_question"
              next unless respond_to?(question)

              send(question).assert_error_message(t(expected_message))
            end
          end
        end

        element :header, :content_header, 'case_heard_by.header'

        # @!method case_heard_by_preference_question
        #   A govuk radio button component for the case heard by preference question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
        gds_radios :case_heard_by_preference_question, :'questions.case_heard_by_preference'

        # @!method case_heard_by_preference_reason_question
        #   A govuk text area component for the optional case heard by preference reason question
        #   @return [EtTestHelpers::Components::GovUKTextArea] The site prism section
        gds_text_area :case_heard_by_preference_reason_question,
                      :'questions.case_heard_by_preference_reason'

        # @!method save_and_continue_button
        #   A govuk submit button component...
        #   @return [EtTestHelpers::Components::GovUKSubmit] The site prism section
        gds_submit_button :save_and_continue_button, :'helpers.submit.update'
      end
    end
  end
end
