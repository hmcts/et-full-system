require_relative './base'
module EtFullSystem
  module Test
    module FileObjects
      module Et3PdfFileSection
        class ContractClaimSection < ::EtFullSystem::Test::FileObjects::Et3PdfFileSection::Base
          def has_contents_for?(respondent:)
            expected_values = {
              make_employer_contract_claim: respondent[:make_employer_contract_claim]&.end_with?('yes') || false,
              information: respondent[:make_employer_contract_claim]&.end_with?('yes') ? respondent[:claim_information] : ''
            }
            expect(mapped_field_values).to include(expected_values)
          end
        end
      end
    end
  end
end
