module EtFullSystem
  module Test
    module CcdOfficeLookUp
      include Admin
      def office_lookup
        return Thread.current['ccd_office_lookup'] if Thread.current['ccd_office_lookup']

        systems = admin_api.external_systems(q: { reference_starts_with: 'ccd_' })
        Thread.current['ccd_office_lookup'] = systems.inject({}.with_indifferent_access) do |acc, system|
          office_code = system['office_codes'].first
          single_config = system['configurations'].detect { |c| c['key'] == 'case_type_id' }
          multiples_config = system['configurations'].detect { |c| c['key'] == 'multiples_case_type_id' }
          next acc if office_code.nil? || single_config.nil? || multiples_config.nil?

          acc[office_code.to_s] = {
              single: {
                  case_type_id: single_config['value']
              },
              multiple: {
                  case_type_id: multiples_config['value']
              }
          }
          acc
        end
      end
    end
  end
end
