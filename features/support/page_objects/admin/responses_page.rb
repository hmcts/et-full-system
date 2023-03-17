module EtFullSystem
  module Test
    module Admin
      class ResponsesPage < Admin::BasePage
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
          expected_values = user.to_h.transform_values do |v|
            next v.to_s unless v.is_a?(Symbol)
            next v.to_s unless v.to_s.split('.').last =~ /\Ayes|no\z/
            v.to_s.split('.').last == 'yes'
          end
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
        expected_values = user.to_h.transform_values do |v|
          next v.to_s unless v.is_a?(Symbol)
          next v.to_s unless v.to_s.split('.').last =~ /\Ayes|no\z/
          v.to_s.split('.').last == 'yes'
          end
        static_values = expected_values.slice(:defend_claim, :claimants_name)
        expected_values = expected_values.to_h.transform_values do |v|
          next v unless v == false || v == ""
          expected_values[v] = nil
          end
        expected_values[:defend_claim] = static_values[:defend_claim]
        expected_values[:claimants_name] = static_values[:claimants_name]
        expect(responses_data.first).to include(expected_values.except(:disagree_claimant_notice_reason, :disagree_claimant_pension_benefits_reason, :allow_video_attendance).stringify_keys)
        end
        #TODO: remove exceptions (see bug ticket RST-4945)
      end
    end
  end
end