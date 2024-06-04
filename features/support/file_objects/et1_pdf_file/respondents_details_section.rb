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
                  details: [respondents.first.building, respondents.first.street, respondents.first.locality, respondents.first.county].reject(&:blank?).join("\n"),
                  post_code: post_code_for(respondents.first.post_code)
                },
                acas: {
                  have_acas: respondents.first.acas_number.present?,
                  acas_number: respondents.first.acas_number || '',
                  no_acas_number_reason: respondents.first.no_acas_number_reason.to_s.split('.').last
                },
                different_address: {
                  details: [respondents.first.work_building, respondents.first.work_street, respondents.first.work_locality, respondents.first.work_county].reject(&:blank?).join("\n"),
                  post_code: post_code_for(respondents.first.work_post_code, optional: true) || ''
                },
                additional_respondents: respondents.length > 1 ? true : false,
                respondent2: {
                  name: title_for(respondents[1].try(:name), optional: true) || '',
                  address: {
                    details: [respondents[1].try(:building), respondents[1].try(:street), respondents[1].try(:locality), respondents[1].try(:county)].reject(&:blank?).join("\n"),
                    post_code: post_code_for(respondents[1].try(:post_code), optional: true) || ''
                  },
                  acas: {
                    have_acas: respondents[1]&.acas_number&.present?,
                    acas_number: respondents[1].try(:acas_number) || ''
                  }
                },
                respondent3: {
                    name: title_for(respondents[2].try(:name), optional: true) || '',
                    address: {
                      details: [respondents[2].try(:building), respondents[2].try(:street), respondents[2].try(:locality), respondents[2].try(:county)].reject(&:blank?).join("\n"),
                      post_code: post_code_for(respondents[2].try(:post_code), optional: true) || ''
                    },
                    acas: {
                      have_acas: respondents[2]&.acas_number&.present?,
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
