require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class EmployersContractClaimPage < BasePage
        set_url '/respond/employers_contract_claim'
        element :error_header, :error_titled, 'errors.header', exact: true
        section :make_employer_contract_claim_question, :single_choice_option, 'questions.make_employer_contract_claim.label', exact: true do
          section :no, :gds_multiple_choice_option, 'questions.make_employer_contract_claim.no.label', exact: true do
            element :selector, :css, 'input'
            delegate :set, to: :selector
          end
          section :yes, :gds_multiple_choice_option, 'questions.make_employer_contract_claim.yes.label', exact: true do
            element :selector, :css, 'input'
            delegate :set, to: :selector
          end
          section :claim_information, :textarea_labelled, 'questions.make_employer_contract_claim.claim_information.label', exact: true do
            delegate :set, to: :root_element
          end
          element :error_too_long, :exact_error_text, 'errors.messages.too_long', exact: false
          def set_for(user_persona)
            if user_persona.make_employer_contract_claim == "Yes"
              yes.set(true)
              claim_information.set(user_persona.claim_information)
            else
              no.set(true)
            end
          end
        end
        element :continue_button, :button, "Save and continue"
        def next
          continue_button.click
        end
      end
    end
  end
end
