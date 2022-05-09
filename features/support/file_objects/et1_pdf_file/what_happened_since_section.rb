require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class WhatHappenedSinceSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(employment:)
            if employment.employment_details == :"claims.employment.no"
              expected_values = {
                have_another_job: be_blank,
                start_date: be_blank,
                salary: be_blank
            }
            elsif employment.new_job == :"claims.employment.new_job.yes"
              expected_values = {
                  have_another_job: employment.new_job.to_s.split('.').last == "yes",
                  start_date: date_for(employment.new_job_start_date),
                  salary: employment.new_job_pay_before_tax
              }
            else
              expected_values = {
                  have_another_job: be_blank,
                  start_date: be_blank,
                  salary: be_blank
              }
            end
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
