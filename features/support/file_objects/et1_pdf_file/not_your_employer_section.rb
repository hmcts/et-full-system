require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class NotYourEmployerSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(employment:)
            expected_values = {
              was_employed: employment.employment_details.to_s.split('.').last == 'yes'
            }
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
