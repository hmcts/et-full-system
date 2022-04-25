require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class GroupClaimantsPage < BasePage
        include RSpec::Matchers
        # Group claims
        element :page_header, :page_title, 'claims.additional_claimants.header', exact: false
        # @!method error_summary
        #   A govuk error component
        #   @return [EtTestHelpers::Components::GovUKErrorSummary] The site prism section
        gds_error_summary :error_summary, :'shared.error_notification.default_message'

        # People making a claim with you
        element :legend_group_claims, :legend_header, 'claims.additional_claimants.subheader', exact: false
        gds_radios :has_multiple_claimants, :'simple_form.labels.additional_claimants.has_multiple_claimants'

        section :number_claimants_info, '#number_claimants_info' do
          element :five_more_claimants, :panel_indent, 'claims.additional_claimants.number_claimants_info', exact: false
          element :six_more_claimants, :panel_indent, 'claims.additional_claimants.csv_upload_text_html', exact: false
          element :csv_upload_link, :link_named, 'claims.additional_claimants.csv_upload_link', exact: false
        end

        section :about_claimant_2, GroupClaimantSection, :group_claimants, 'claims.additional_claimants.person',
                number: 2
        section :about_claimant_3, GroupClaimantSection, :group_claimants, 'claims.additional_claimants.person',
                number: 3
        section :about_claimant_4, GroupClaimantSection, :group_claimants, 'claims.additional_claimants.person',
                number: 4
        section :about_claimant_5, GroupClaimantSection, :group_claimants, 'claims.additional_claimants.person',
                number: 5
        section :about_claimant_6, GroupClaimantSection, :group_claimants, 'claims.additional_claimants.person',
                number: 6

        gds_submit_button :add_more_claimants_link, :'claims.additional_claimants.add_fields'
        gds_submit_button :save_and_continue_button, t('helpers.submit.update')

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def add_more_claimants
          add_more_claimants_link.click
        end

        def save_and_continue
          page.scroll_to(save_and_continue_button, align: :bottom)
          save_and_continue_button.click
        end

        def has_correct_translation_on_group_claims?
          # your feedback header
          expect(feedback_notice).to have_language
          expect(feedback_notice).to have_feedback_link
          expect(feedback_notice).to have_feedback_info
          # Group claims
          expect(self).to have_page_header
          # people making a claim with you
          expect(self).to have_legend_group_claims
          has_multiple_claimants.assert_valid_options
          # save and continue
          expect(self).to have_save_and_continue_button
          # Support links
          expect(support).to have_suport_header
          expect(support).to have_guide
          expect(support).to have_contact_use
          # Save your claim later
          expect(support).to have_your_claim
          # TODO: this has stopped working - why?
          # expect(support).to have_save_and_complete_later
        end

        def has_correct_translation_for_group_claimants?
          # For 5 or fewer claimants, enter their details below
          expect(number_claimants_info).to have_five_more_claimants
          # For 6 or more claimants, you can upload their details in a separate spreadsheet.
          expect(number_claimants_info).to have_six_more_claimants
          expect(number_claimants_info).to have_csv_upload_link
          # Claimant 2
          expect(about_claimant_2).to have_title
          expect(about_claimant_2).to have_first_name
          expect(about_claimant_2).to have_last_name
          # date of birth
          expect(about_claimant_2).to have_date_of_birth
          expect(about_claimant_2.date_of_birth).to have_hint(text: t('simple_form.hints.claimant.date_of_birth'))
          expect(about_claimant_2).to have_building
          expect(about_claimant_2).to have_street
          expect(about_claimant_2).to have_locality
          expect(about_claimant_2).to have_county
          expect(about_claimant_2).to have_post_code
          # Add more claimants
          expect(self).to have_add_more_claimants_link
        end

        def has_correct_mandatory_error_msg_for_group_claimants?
          # Errors on page
          expect(self).to have_error_summary
          expect(about_claimant_2.first_name).to have_error(text: t('activemodel.errors.models.additional_claimants_form/additional_claimant.attributes.first_name.blank'))
          expect(about_claimant_2.last_name).to have_error(text: t('activemodel.errors.models.additional_claimants_form/additional_claimant.attributes.last_name.blank'))
          expect(about_claimant_2.date_of_birth).to have_error(text: t('activemodel.errors.models.claimant.attributes.date_of_birth.too_young'))
          expect(about_claimant_2.building).to have_error(text: t('activemodel.errors.models.additional_claimants_form/additional_claimant.attributes.address_building.blank'))
          expect(about_claimant_2.street).to have_error(text: t('activemodel.errors.models.additional_claimants_form/additional_claimant.attributes.address_street.blank'))
          expect(about_claimant_2.locality).to have_error(text: t('activemodel.errors.models.additional_claimants_form/additional_claimant.attributes.address_locality.blank'))
          expect(about_claimant_2.county).to have_error(text: t('activemodel.errors.models.additional_claimants_form/additional_claimant.attributes.address_county.blank'))
          expect(about_claimant_2.post_code).to have_error(text: t('activemodel.errors.models.additional_claimants_form/additional_claimant.attributes.address_post_code.blank'))
        end

        def has_correct_invalid_error_msg_for_dob?
          expect(about_claimant_2.date_of_birth).to have_error(text: t('activemodel.errors.models.claimant.attributes.date_of_birth.invalid'))
        end

        def set(data)
          group_claims_csv = data[0].dig(:group_claims_csv)
          if data.length > 1 || group_claims_csv.present?
            has_multiple_claimants.set(:yes)
            data.drop(1).each.with_index do |claimant, idx|
              add_more_claimants unless idx == 0
              populate_group_claim_section(claimant.to_h, idx + 2)
            end
            number_claimants_info.csv_upload_link.click if group_claims_csv.present?
          else
            has_multiple_claimants.set(:no)
          end
        end

        private

        def upload_page
          AdditionalClaimantsUploadPage.new
        end

        def populate_group_claim_section(claimant_data, claimant_number)
          s = send(:"about_claimant_#{claimant_number}")
          set_field s, :title, claimant_data
          set_field s, :first_name, claimant_data
          set_field s, :last_name, claimant_data
          set_field s, :date_of_birth, claimant_data
          set_field s, :building, claimant_data
          set_field s, :street, claimant_data
          set_field s, :locality, claimant_data
          set_field s, :county, claimant_data
          set_field s, :post_code, claimant_data
        end

        def set_field(s, key, data)
          s.send(key).set(data[key]) if data.key?(key)
        end
      end
    end
  end
end
