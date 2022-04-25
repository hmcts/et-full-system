require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class RepresentativesDetailsPage < BasePage
        include RSpec::Matchers
        # Representative's details
        element :page_header, :page_title, 'claims.representative.header', exact: false
        # @!method error_summary
        #   A govuk error component
        #   @return [EtTestHelpers::Components::GovUKErrorSummary] The site prism section
        gds_error_summary :error_summary, :'shared.error_notification.default_message'

        # The person representing you
        gds_radios :representative, :'simple_form.labels.representative.has_representative'

        # All correspondence
        element :contact_info, :paragraph, 'claims.representative.contact_info', exact: false
        # About your representative
        element :about_your_representative, :legend_header, 'claims.representative.representative_legend'
        # @!method type
        #   A govukselect component wrapping the select, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKCollectionSelect] The site prism section
        gds_select :type, :'claims.representative.representative_type_legend'
        section :organisation_name, :question_labelled, 'simple_form.labels.representative.organisation_name' do
          element :field, :css, 'input'
          def set(*args)
            field.set(*args)
          end
        end
        section :name, :question_labelled, 'simple_form.labels.representative.name' do
          element :blank_organisation_name, :error, 'activemodel.errors.models.representative.attributes.name.blank'
          element :field, :css, 'input'
          def set(*args)
            field.set(*args)
          end
        end
        # Representative's contact details
        element :representative_contact_details, :legend_header, 'claims.representative.contact_legend'
        # @!method building
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :building, :'simple_form.labels.representative.address_building'
        # @!method street
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :street, :'simple_form.labels.representative.address_street'
        # @!method locality
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :locality, :'simple_form.labels.representative.address_locality'
        # County
        # @!method county
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :county, :'simple_form.labels.representative.address_county'
        # @!method post_code
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :post_code, :'simple_form.labels.representative.address_post_code'
        element :blank_telephone_number, :error,
                'activemodel.errors.models.representative.attributes.address_locality.blank'
        section :telephone_number, :question_labelled, 'simple_form.labels.representative.address_telephone_number' do
          element :field, :css, 'input'
          def set(*args)
            field.set(*args)
          end
        end
        element :blank_mobile, :error, 'activemodel.errors.models.representative.attributes.address_locality.blank'
        section :alternative_telephone_number, :question_labelled,
                'simple_form.labels.representative.mobile_number' do
          element :field, :css, 'input'
          def set(*args)
            field.set(*args)
          end
        end
        element :invalid_email_address, :error,
                'activemodel.errors.models.representative.attributes.email_address.invalid'
        element :blank_email_address, :error,
                'activemodel.errors.models.representative.attributes.email_address.blank'
        gds_email_input :email_address, :'simple_form.labels.representative.email_address'

        # @!method representative_contact_preference
        #   A govuk radio button component for contact_preference question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
        gds_radios :representative_contact_preference, :'claims.representative.contact_preference.label'

        gds_text_input :dx_number, :'simple_form.labels.representative.dx_number'
        # What is Dx number?
        element :what_is_dx_number, :summary_text, 'claims.representative.what_is_dx.detail'
        element :dx_information, :paragraph, 'claims.representative.what_is_dx.summary'
        # Save and continue
        gds_submit_button :save_and_continue_button, t('helpers.submit.update')

        def save_and_continue
          page.scroll_to(save_and_continue_button, align: :bottom)
          save_and_continue_button.click
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def has_correct_translation?
          # your feedback header
          expect(feedback_notice).to have_language
          expect(feedback_notice).to have_feedback_link
          expect(feedback_notice).to have_feedback_info
          # Page header
          expect(self).to have_page_header
          # The person representating you
          representative.assert_valid_options
          # All correspondence
          expect(self).to have_contact_info
          # About your representative
          expect(self).to have_about_your_representative
          # Type of presentative
          expect(self).to have_type
          expect(self).to have_organisation_name
          expect(self).to have_name
          # Representative contact details
          expect(self).to have_representative_contact_details
          expect(self).to have_building
          expect(self).to have_street
          expect(self).to have_locality
          expect(self).to have_county
          expect(county).to have_hint(text: t('simple_form.hints.representative.address_county'))
          expect(self).to have_post_code
          expect(self).to have_telephone_number
          expect(self).to have_alternative_telephone_number
          expect(self).to have_representative_contact_preference
          # What is DX number
          expect(self).to have_what_is_dx_number
          # Save and continue
          expect(self).to have_save_and_continue_button
          # Support
          expect(support).to have_suport_header
          expect(support).to have_guide
          expect(support).to have_contact_use
          # Save your claim later
          expect(support).to have_your_claim
          # TODO: this has stopped working - why?
          # expect(support).to have_save_and_complete_later
        end

        def has_correct_validation_error_message?
          expect(self).to have_error_summary
          expect(self).to have_type
          expect(self).to have_name
          expect(building).to have_error(text: t('activemodel.errors.models.representative.attributes.address_building.blank'))
          expect(street).to have_error(text: t('activemodel.errors.models.representative.attributes.address_street.blank'))
          expect(locality).to have_error(text: t('activemodel.errors.models.representative.attributes.address_locality.blank'))
          expect(county).to have_error(text: t('activemodel.errors.models.representative.attributes.address_county.blank'))
          expect(post_code).to have_error(text: t('activemodel.errors.models.representative.attributes.address_post_code.blank'))
          representative_contact_preference.assert_error_message(t('claims.representative.contact_preference.errors.blank'))
          true
        end

        def has_correct_error_message_for_invalid_uk_postcode?
          expect(post_code).to have_error(text: t('activemodel.errors.models.representative.attributes.address_post_code.invalid'))
        end

        def has_correct_dx_information?
          expect(self).to have_dx_information
        end

        def set(user)
          data = user[0].to_h
          if data[:representative_have] == 'Yes'
            representative.set(:yes)
            set_field :type, data
            set_field :organisation_name, data
            set_field :name, data
            set_field :building, data
            set_field :street, data
            set_field :locality, data
            set_field :county, data
            set_field :post_code, data
            set_field :telephone_number, data
            set_field :alternative_telephone_number, data
            set_field :representative_contact_preference, data
            set_field :email_address, data if data[:representative_contact_preference].to_s.split('.').last == 'email'
            set_field :dx_number, data if data[:representative_contact_preference].to_s.split('.').last == 'dx_number'
          else
            representative.set(:no)
          end
        end

        private

        def set_field(key, data)
          if data.key?(key)
            send(key).set(data[key])
          else
            send(key).set('')
          end
        end
      end
    end
  end
end
