require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class RespondentsDetailsPage < BasePage
        include RSpec::Matchers
        # Respondent's details
        element :page_header, :page_title, 'claims.respondent.header', exact: false
        # @!method error_summary
        #   A govuk error component
        #   @return [EtTestHelpers::Components::GovUKErrorSummary] The site prism section
        gds_error_summary :error_summary, :'shared.error_notification.default_message'

        # About the respondent
        element :respondent_header, :legend_header, 'claims.respondent.respondent_legend'
        element :respondent_summary, :paragraph, 'claims.respondent.form_hint'
        # @!method name
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :name, :'simple_form.labels.respondent.name'
        # @!method building
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :building, :'simple_form.labels.respondent.address_building'
        # @!method street
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :street, :'simple_form.labels.respondent.address_street'
        # @!method locality
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :locality, :'simple_form.labels.respondent.address_locality'
        # @!method county
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :county, :'simple_form.labels.respondent.address_county'

        # @!method post_code
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :post_code, :'simple_form.labels.respondent.address_post_code'

        gds_phone_input :telephone_number, :'simple_form.labels.respondent.address_telephone_number'
        # Your work address
        element :work_address_header, :legend_header, 'claims.respondent.workaddress_legend'

        # @!method work_address
        #   A govuk fieldset component
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_fieldset :work_address, :'claims.respondent.workaddress_legend' do
          include EtTestHelpers::Section
          element :work_address_hint, :paragraph, 'claims.respondent.work_address'

          gds_radios :same_address, :'simple_form.labels.respondent.worked_at_same_address'

          # @!method building
          #   A govuk text field component wrapping the input, label, hint etc..
          #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
          gds_text_input :building, :'simple_form.labels.respondent.work_address_building'
          # @!method street
          #   A govuk text field component wrapping the input, label, hint etc..
          #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
          gds_text_input :street, :'simple_form.labels.respondent.work_address_street'
          # @!method locality
          #   A govuk text field component wrapping the input, label, hint etc..
          #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
          gds_text_input :locality, :'simple_form.labels.respondent.work_address_locality'
          # @!method county
          #   A govuk text field component wrapping the input, label, hint etc..
          #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
          gds_text_input :county, :'simple_form.labels.respondent.work_address_county'
          # @!method post_code
          #   A govuk text field component wrapping the input, label, hint etc..
          #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
          gds_text_input :post_code, :'simple_form.labels.respondent.work_address_post_code'

          # @!method telephone_number
          #   A govuk phone field component representing the phone or mobile question
          #   @return [EtTestHelpers::Components::GovUKPhoneField] The site prism section
          gds_phone_input :telephone_number, :'simple_form.labels.respondent.work_address_telephone_number'
        end

        # Acas early conciliation certificate number
        # @!method acas_certificate_number
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :acas_certificate_number, :'claims.respondent.acas_legend'

        # @!method no_acas_number
        #   A govuk radio button component for no_acas_number question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
        gds_radios :no_acas_number, :'simple_form.labels.respondent.no_acas_number'

        # I don't have an Acas number
        # @!method respondent_no_acas_number_reason
        #   A govuk radio button component for respondent_no_acas_number_reason question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
        gds_radios :respondent_no_acas_number_reason, :'claims.respondent.no_acas_number_reason'
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
          # Respoondent's details
          expect(self).to have_page_header
          # About the respondent
          expect(self).to have_respondent_header
          expect(self).to have_respondent_summary
          # Respondent contact details
          expect(self).to have_name
          expect(self).to have_building
          expect(self).to have_street
          expect(self).to have_locality
          expect(self).to have_county
          county.assert_valid_hint
          expect(self).to have_post_code
          expect(self).to have_telephone_number
          # Your work address
          expect(self).to have_work_address_header
          work_address.same_address.assert_valid_options
          # Different work address
          expect(work_address).to have_work_address_hint
          expect(work_address).to have_building
          expect(work_address).to have_street
          expect(work_address).to have_locality
          expect(work_address).to have_county
          work_address.county.assert_valid_hint
          expect(work_address).to have_post_code
          expect(work_address).to have_telephone_number
          # Acas early conciliation certifcate number
          acas_certificate_number.assert_valid_hint
          # I don't have an acas number
          expect(self).to have_no_acas_number
          # Why don't you have an Acas number?
          respondent_no_acas_number_reason.assert_valid_hint
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

        def has_correct_blank_validation_error_messages?
          expect(self).to have_error_summary
          name.assert_valid_error(:blank)
          street.assert_valid_error(:blank)
          locality.assert_valid_error(:blank)
          county.assert_valid_error(:blank)
          post_code.assert_valid_error(:blank)
          work_address.building.assert_valid_error(:blank)
          work_address.street.assert_valid_error(:blank)
          work_address.locality.assert_valid_error(:blank)
          work_address.post_code.assert_valid_error(:blank)
          acas_certificate_number.assert_valid_error(:blank)
          true
        end

        def has_correct_error_message_for_invalid_uk_postcode?
          post_code.assert_valid_error(:invalid)
          true
        end

        def set(respondent)
          data = respondent[0].to_h
          return if data.nil? || data.empty?

          set_field :name, data
          set_field :building, data
          set_field :street, data
          set_field :locality, data
          set_field :county, data
          set_field :post_code, data
          set_field :telephone_number, data

          if data.key?(:work_building)
            work_address.same_address.set(:no)
            work_address.building.set(data[:work_building])
            work_address.street.set(data[:work_street])
            work_address.locality.set(data[:work_locality])
            work_address.county.set(data[:work_county])
            work_address.post_code.set(data[:work_post_code])
            work_address.telephone_number.set(data[:work_telephone_number])
          else
            work_address.same_address.set(:yes)
          end

          if data.key?(:no_acas_number_reason)
            no_acas_number.set(:no)
            respondent_no_acas_number_reason.set(data[:no_acas_number_reason])
          else
            no_acas_number.set(:yes)
          end
          return unless data.key?(:acas_number)

          no_acas_number.set(:yes)
          acas_certificate_number.set(data[:acas_number])
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
