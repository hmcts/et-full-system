require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class YourRepresentativesDetailsPage < BasePage
        include EtTestHelpers::Page
        include RSpec::Matchers
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :govuk_link, :'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        # Your representative details age
        element :header, :content_header, 'your_representatives_details.header'
        gds_radios :type_of_representative_question, :'questions.type_of_representative', exact: false
        gds_text_input :representative_org_name_question, :'questions.representative_org_name', exact: false
        gds_text_input :representative_name_question, :'questions.representative_name', exact: false
        gds_text_input :representative_building_question, :'questions.representative_building', exact: false
        gds_text_input :representative_street_question, :'questions.representative_street', exact: false
        gds_text_input :representative_town_question, :'questions.representative_town', exact: false
        gds_text_input :representative_county_question, :'questions.representative_county', exact: false
        gds_text_input :representative_postcode_question, :'questions.representative_postcode', exact: false
        gds_text_input :representative_phone_question, :'questions.representative_phone', exact: false
        gds_text_input :representative_mobile_question, :'questions.representative_mobile', exact: false
        gds_text_input :representative_dx_number_question, :'questions.representative_dx_number', exact: false
        gds_text_input :representative_reference_question, :'questions.representative_reference', exact: false
        gds_radios :representative_contact_preference_question, :'questions.representative_contact_preference', exact: false
        gds_text_input :preference_email, :'questions.preference_email'
        # @!method allow_phone_or_video_attendance_question
        #   A govuk radio button component for the phone or video question
        #   @return [EtTestHelpers::Components::GovUKCollectionCheckBoxes] The site prism section
        gds_checkboxes :allow_phone_or_video_attendance_question, :'questions.representative_allow_phone_or_video_attendance', exact: false


        # Save and continue
        gds_submit_button :continue_button, :'components.save_and_continue_button'
        def next
          continue_button.click
        end

        def switch_to_welsh
          switch_language.welsh_link.click
        end

        def switch_to_english
          switch_language.english_link.click
        end
      end
    end
  end
end
