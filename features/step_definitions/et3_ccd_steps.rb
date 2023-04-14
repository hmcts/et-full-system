
And(/^the submitted Employment Tribunal response is exported to ccd for me$/) do
  ccd_system = admin_api.external_systems(q: { reference_starts_with: 'ccd_' }).detect do |system|
    system[:office_codes].include?(@my_et3_reference[0..1].to_i)
  end
  admin_api.export_response_to_ccd(external_system_id: ccd_system['id'], response_reference: @my_et3_reference)
end
