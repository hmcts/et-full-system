require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class InformationToRegulatorsSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(claim:)
            expected_values = {
              whistle_blowing: claim.claim_types.whistleblowing_claim.to_s.split('.').last == 'yes',
            }
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
