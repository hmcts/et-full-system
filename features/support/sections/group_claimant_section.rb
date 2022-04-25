module EtFullSystem
  module Test
    class GroupClaimantSection < BaseSection
      include EtTestHelpers::Section
      gds_select :title, :'simple_form.labels.claimant.title'
      # first name
      # @!method first_name
      #   A govuk text field component wrapping the input, label, hint etc..
      #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
      gds_text_input :first_name, :'simple_form.labels.claimant.first_name'

      # lastname name
      # @!method last_name
      #   A govuk text field component wrapping the input, label, hint etc..
      #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
      gds_text_input :last_name, :'simple_form.labels.claimant.last_name'

      # Date of birth
      # @!method date_of_birth
      #   A govuk date field component wrapping the inputs, label, hint etc.. for the date of birth question
      #   @return [EtTestHelpers::Components::GovUKDateField] The site prism section
      gds_date_input :date_of_birth, :'claims.personal_details.date_of_birth'
      # Building number or name
      # @!method building
      #   A govuk text field component wrapping the input, label, hint etc..
      #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
      gds_text_input :building, :'simple_form.labels.claimant.address_building'

      # Street
      # @!method street
      #   A govuk text field component wrapping the input, label, hint etc..
      #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
      gds_text_input :street, :'simple_form.labels.claimant.address_street'

      # Town/city
      # @!method locality
      #   A govuk text field component wrapping the input, label, hint etc..
      #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
      gds_text_input :locality, :'simple_form.labels.claimant.address_locality'

      # County
      # @!method county
      #   A govuk text field component wrapping the input, label, hint etc..
      #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
      gds_text_input :county, :'simple_form.labels.claimant.address_county'

      # Postcode
      # @!method post_code
      #   A govuk text field component wrapping the input, label, hint etc..
      #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
      gds_text_input :post_code, :'simple_form.labels.claimant.address_post_code'
    end
  end
end
