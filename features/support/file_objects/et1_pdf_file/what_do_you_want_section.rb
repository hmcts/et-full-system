require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class WhatDoYouWantSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(claim:)
            outcome_types = outcome_types_for(claim.preferred_outcome)
            expected_values = {
              prefer_re_instatement: outcome_types.include?(:prefer_re_instatement),
              prefer_re_engagement: outcome_types.include?(:prefer_re_engagement),
              prefer_compensation: outcome_types.include?(:prefer_compensation),
              prefer_recommendation: outcome_types.include?(:prefer_recommendation),
              compensation: claim.preferred_outcome_notes
            }
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
