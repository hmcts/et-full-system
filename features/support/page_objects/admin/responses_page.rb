module EtFullSystem
  module Test
    module Admin
      class ResponsesPage < Admin::BasePage
        QUESTIONS_WITH_NOT_APPLICABLE = [:agree_with_claimants_description_of_job_or_title, :agree_with_claimants_hours, :agree_with_earnings_details, :agree_with_claimant_notice, :agree_with_claimant_pension_benefits, :agree_with_employment_dates, :continued_employment].freeze
        set_url "/responses"

        element :reference_value, 'td.col.col-reference'
        element :respondent_name, 'td.col.col-respondent_name'
        element :case_number, 'td.col.col-case_number'
        element :claimant_name, 'td.col.col-claimants_name'



        def find_user(user, reference)
          expect(self).to be_displayed()
          expect(respondent_name).to have_content(user.name)
          expect(reference_value).to have_content(reference)
          expect(case_number).to have_content(user.case_number)
          expect(claimant_name).to have_content(user.claimants_name)
        end

        def check_json(user, reference)
          responses_data = admin_api.responses(q:{reference_cont:reference})
          date_keys = [:employment_end, :employment_start]
          expected_values = user.to_h.map do |k, v|
            next [k, v.to_s] unless v.is_a?(Symbol)
            next [k, v.to_s] unless v.to_s.split('.').last =~ /\Ayes|no\z/
            next [k, v.to_s.split('.').last == 'yes'] unless k.in?(QUESTIONS_WITH_NOT_APPLICABLE)
            [k, v.to_s.split('.').last == 'yes' ? 'true' : 'false']
          end.to_h

          if expected_values[:employment_end] != ""
            expected_values.each_pair do |k,v|
              expected_values[k] = k.in?(date_keys) ? Date.parse(v).strftime('%Y-%m-%d') : v
            end
          else
            expected_values[:disagree_employment] = nil
            expected_values[:employment_end] = nil
            expected_values[:employment_start] = nil
            expected_values = expected_values.to_h.transform_values do |v|
              next v unless v == ""
              v == nil
            end
          end
          expect(responses_data.first).to include(expected_values.except(:disagree_claimant_notice_reason, :disagree_claimant_pension_benefits_reason).stringify_keys)
          #TODO: remove exceptions (see bug ticket RST-4945)
        end

        def minimal_check_json(user, reference)
          responses_data = admin_api.responses(q:{reference_cont:reference})
          expected_values = user.to_h.map do |k, v|
            next [k, v.to_s] unless v.to_s.split('.').last =~ /\Ayes|no\z/
            next [k, v.to_s.split('.').last == 'yes'] unless k.in?(QUESTIONS_WITH_NOT_APPLICABLE)
            [k, v.to_s.split('.').last.then {|value| value.nil? ? nil : (value == 'yes' ? 'true' : 'false') }]
          end.to_h
          static_values = expected_values.slice(:defend_claim, :claimants_name)
          expected_values = expected_values.to_h.transform_values do |v|
            next v unless v == false || v == ""
            expected_values[v] = nil
          end
          expected_values[:defend_claim] = static_values[:defend_claim]
          expected_values[:claimants_name] = static_values[:claimants_name]
          expected_values[:allow_phone_attendance] = expected_values[:allow_phone_or_video_attendance].include?('phone')
          expected_values[:allow_video_attendance] = expected_values.delete(:allow_phone_or_video_attendance).include?('phone')
          expect(responses_data.first).to include(expected_values.except(:disagree_claimant_notice_reason, :disagree_claimant_pension_benefits_reason, :allow_video_attendance, :allow_phone_attendance).stringify_keys)
          #TODO: remove exceptions (see bug ticket RST-4945)
        end

        def change_office()
          data = self.page.find(:css, "a[href='/admin/responses?scope=all']").text.delete('All ()') # This allows us to create a CSS matcher for the top row of the data
          self.page.find(:css,"tr[id='response_#{data}'] a[title='Edit']").click
          page.find(:css, '#response_office_input .select2-selection__arrow').click
          self.page.find(:css, "span[class='select2-container select2-container--default select2-container--open'] li:nth-child(2)").click
          self.page.find(:css, "input[value='Update Response']").click
        end

        def verify_office()
          data = self.page.find(:css, "a[href='/admin/responses?scope=all']").text.delete('All ()')
          self.page.find(:css, "tr[id='response_#{data}'] td[class='col col-office']").text == "Bristol"
        end
      end
    end
  end
end
