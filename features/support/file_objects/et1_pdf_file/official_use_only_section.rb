require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class OfficialUseOnlySection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(claim:, respondent:)
            office_data = admin_api.office_data_for(respondent.expected_office)
            expected_values = {
              tribunal_office: office_data['name'],
              date_received: eq(date_for(Time.now)).or(eq(date_for(1.hour.ago)))
            }
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
