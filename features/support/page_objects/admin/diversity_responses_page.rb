module EtFullSystem
  module Test
    module Admin
      class DiversityResponsesPage < Admin::BasePage
        set_url "/diversity_responses"

        def has_response_for?(data)
          api = EtFullSystem::Test::AdminApi.new atos_interface: atos_interface
          expected_data = data.to_h.inject({}) do |acc, (k, v)|
            # Value should always be 'diversities.<page>.question.options.<value>'
            acc[k] = v&.to_s&.split('.')&.last
            acc
          end
          expect {api.admin_diversity_data.symbolize_keys}.to eventually include(expected_data), timeout: 30, sleep: 2
          true
        end
      end
    end
  end
end
