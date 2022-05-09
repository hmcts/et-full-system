module EtFullSystem
  module Test
    class AdditionalRespondentSection < BaseSection
      include EtTestHelpers::Section
      # Respondent 2
      gds_text_input :name, :'simple_form.labels.respondent.name'
      gds_text_input :building, :'simple_form.labels.respondent.address_building'
      gds_text_input :street, :'simple_form.labels.respondent.address_street'
      gds_text_input :locality, :'simple_form.labels.respondent.address_locality'
      gds_text_input :county, :'simple_form.labels.respondent.address_county'
      gds_text_input :post_code, :'simple_form.labels.respondent.address_post_code'
      # Acas number
      gds_text_input :acas_number, :'simple_form.labels.respondent.acas_early_conciliation_certificate_number'
      # I don't have an Acas number
      # @!method no_acas_number
      #   A govuk radio button component for no_acas_number question
      #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
      gds_radios :no_acas_number, :'simple_form.labels.respondent.no_acas_number'
      gds_radios :respondent_no_acas_number_reason, :'claims.additional_respondents.no_acas_number_reason'
    end
  end
end
