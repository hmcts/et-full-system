require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class DisabilitySection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(claimant:)
            if claimant.has_special_needs == :"simple_form.no"
              expected_values = {
                has_special_needs: false,
                special_needs: ""
              }
            else
              expected_values = {
                has_special_needs: true,
                special_needs: claimant.special_needs
              }
            end
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
