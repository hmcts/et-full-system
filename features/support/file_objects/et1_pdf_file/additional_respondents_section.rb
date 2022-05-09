require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class AdditionalRespondentsSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(respondents:)
            # claimant.title is a selection of options - in this case we are interested in the key thats all - do not translate it
            if respondents.length > 3
              expected_values = {
                respondent4: {
                    name: respondents[3].try(:name),
                    building: respondents[3].try(:building),
                    street: respondents[3].try(:street),
                    locality: respondents[3].try(:locality),
                    county: respondents[3].try(:county),
                    post_code: post_code_for(respondents[3].try(:post_code), optional: true),
                    telephone_number: "",
                    have_acas: respondents[2]&.acas_number.present?,
                    acas_number: respondents[3].try(:acas_number)

                },
                respondent5: {
                    name: respondents[4].try(:name),
                    building: respondents[4].try(:building),
                    street: respondents[4].try(:street),
                    locality: respondents[4].try(:locality),
                    county: respondents[4].try(:county),
                    post_code: post_code_for(respondents[4].try(:post_code), optional: true),
                    telephone_number: "",
                    have_acas: respondents[4]&.acas_number.present?,
                    acas_number: respondents[4].try(:acas_number)
                }
            }
            else
              expected_values = {
                respondent4: {
                  name: be_blank,
                  building: be_blank,
                  street: be_blank,
                  locality: be_blank,
                  county: be_blank,
                  post_code: be_blank,
                  telephone_number: be_blank,
                  have_acas: be_blank,
                  acas_number: be_blank
                },
                respondent5: {
                  name: be_blank,
                  building: be_blank,
                  street: be_blank,
                  locality: be_blank,
                  county: be_blank,
                  post_code: be_blank,
                  telephone_number: be_blank,
                  have_acas: be_blank,
                  acas_number: be_blank
                }
              }
            end

            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
