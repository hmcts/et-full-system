require_relative './base'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class MultipleCasesSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(claim:)
            other_claims = claim.similar_claims.to_s.split('.').last
            expected_values = if other_claims == 'yes'
                                {
                                  have_similar_claims: true,
                                  other_claimants: claim.other_claimant_names
                                }
                              else
                                {
                                  have_similar_claims: false,
                                  other_claimants: ''
                                }
                              end
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
