require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class RespondentsDetailsSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(respondents:)
            expected_values = {
                name: title_for(respondents.first.name),
                address: {
                    building: respondents.first.building,
                    street: respondents.first.street,
                    locality: respondents.first.locality,
                    county: respondents.first.county,
                    post_code: post_code_for(respondents.first.post_code),
                    telephone_number: respondents.first.telephone_number
                },
                acas: {
                    have_acas: respondents.first.acas_number.present?,
                    acas_number: respondents.first.acas_number || '',
                    no_acas_number_reason: respondents.first.no_acas_number_reason.to_s.split('.').last
                },
                different_address: {
                    building: respondents.first.work_building || '',
                    street: respondents.first.work_street || '',
                    locality: respondents.first.work_locality || '',
                    county: respondents.first.work_county || '',
                    post_code: post_code_for(respondents.first.work_post_code, optional: true) || '',
                    telephone_number: respondents.first.work_telephone_number || ''
                },
                additional_respondents: respondents.length > 1 ? true : false,
                respondent2: {
                    name: title_for(respondents[1].try(:name), optional: true) || '',
                    address: {
                        building: respondents[1].try(:building) || '',
                        street: respondents[1].try(:street) || '',
                        locality: respondents[1].try(:locality) || '',
                        county: respondents[1].try(:county) || '',
                        post_code: post_code_for(respondents[1].try(:post_code), optional: true) || '',
                        telephone_number: ''
                    },
                    acas: {
                        have_acas: respondents[1]&.acas_number.present?,
                        acas_number: respondents[1].try(:acas_number) || ''
                    }
                },
                respondent3: {
                    name: title_for(respondents[2].try(:name), optional: true) || '',
                    address: {
                        building: respondents[2].try(:building) || '',
                        street: respondents[2].try(:street) || '',
                        locality: respondents[2].try(:locality) || '',
                        county: respondents[2].try(:county) || '',
                        post_code: post_code_for(respondents[2].try(:post_code), optional: true) || '',
                        telephone_number: ''
                    },
                    acas: {
                        have_acas: respondents[2]&.acas_number.present?,
                        acas_number: respondents[2].try(:acas_number) || ''
                    }
                }
            }
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
