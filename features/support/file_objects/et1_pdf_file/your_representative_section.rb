require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class YourRepresentativeSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(representative:)
            if representative.representative_have == 'Yes'
              expected_values = {
                  name_of_organisation: representative.organisation_name,
                  name_of_representative: representative.name,
                  building: representative.building,
                  street: representative.street,
                  locality: representative.locality,
                  county: representative.county,
                  post_code: post_code_for(representative.post_code),
                  telephone_number: representative.telephone_number,
                  alternative_telephone_number: representative.alternative_telephone_number,
                  reference: nil, # Should be populated by ET1 but it isnt yet
                  communication_preference: nil, # ET1 Doesnt capture this
                  fax_number: nil, # ET1 Doesnt capture this
                  email_address: be_blank,
                  dx_number: be_blank
              }
              expected_values[:email_address] = representative.email_address if representative.representative_contact_preference.to_s.split('.').last == 'email'
              expected_values[:dx_number] = representative.dx_number  if representative.representative_contact_preference.to_s.split('.').last == 'dx_number'
          else
            expected_values = {
              name_of_organisation: be_blank,
              name_of_representative: be_blank,
              building: be_blank,
              street: be_blank,
              locality: be_blank,
              county: be_blank,
              post_code: be_blank,
              dx_number: be_blank,
              telephone_number: be_blank,
              alternative_telephone_number: be_blank,
              reference: be_blank,
              email_address: be_blank,
              communication_preference: be_blank,
              fax_number: be_blank
          }
          end
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
