require_relative './base'
module EtFullSystem
  module Test
    module FileObjects
      module Et3PdfFileSection
        class RespondentSection < ::EtFullSystem::Test::FileObjects::Et3PdfFileSection::Base
          def has_contents_for?(respondent:)
            respondent = respondent.to_h
            expected_values = {
              name: respondent[:name],
              contact: respondent.fetch(:contact, ''),
              address: a_hash_including(
                building: respondent[:building_name],
                street: respondent[:street_name],
                locality: respondent[:town],
                county: respondent[:county],
                post_code: respondent[:postcode].tr(' ', '')
              ),
              address_dx_number: respondent[:dx_number] || '',
              phone_number: respondent[:contact_number] || '',
              mobile_number: respondent[:contact_mobile_number] || '',
              contact_preference: contact_preference(respondent[:contact_preference]),
              allow_video_attendance: respondent[:allow_phone_or_video_attendance].include?(:video),
              allow_phone_attendance: respondent[:allow_phone_or_video_attendance].include?(:phone),
              email_address: respondent.fetch(:email_address, ''),
              employ_gb: respondent[:organisation_employ_gb].to_s,
              multi_site_gb: respondent[:organisation_more_than_one_site] == 'Yes',
              employment_at_site_number: respondent[:employment_at_site_number].to_s
            }
            expect(mapped_field_values).to match(expected_values)
          end

          def contact_preference(preference)
            return nil if preference.nil?
            t(preference).downcase
          end
        end
      end
    end
  end
end
