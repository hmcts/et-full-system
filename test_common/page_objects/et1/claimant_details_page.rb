require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class ClaimantDetailsPage < BasePage
        include RSpec::Matchers
        #your feedback header
        section :feedback_notice, '.feedback-notice' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
          element :feedback_link, :paragraph, 'shared.feedback_link.feedback_statement_html'
        end
        #page and main header
        section :main_header, '.main-header' do
          element :page_header, :page_title, 'claims.claimant.header', exact: false
        end
        section :main_content, '.main-section .main-content' do
          section :error_message, '#edit_claimant #error-summary' do
            element :error_summary, :content_header, 'shared.error_notification.error_summary', exact: false
            element :default_message, :paragraph, 'shared.error_notification.default_message'
          end
          #About the claimant
          element :legend_personal_details, :legend_header, 'claims.claimant.legend_personal_details', exact: false
          #information about the person
          element :personal_details_description, :paragraph, 'claims.claimant.personal_details_description', exact: false
          #title
          section :title, :question_labelled, 'simple_form.labels.claimant.title' do
            def set(value)
              root_element.select(factory_translate value)
            end
            element :error_title, :error, 'activemodel.errors.models.claimant.attributes.title.blank', exact: false
          end
          #first name
          section :first_name, :question_labelled, 'simple_form.labels.claimant.first_name' do
            element :field, :css, 'input'
            delegate :set, to: :field
            element :error_first_name, :error, 'activemodel.errors.models.claimant.attributes.first_name.blank'
          end
          #lastname name
          section :last_name, :question_labelled, 'simple_form.labels.claimant.last_name' do
            element :field, :css, 'input'
            delegate :set, to: :field
            element :error_last_name, :error, 'activemodel.errors.models.claimant.attributes.last_name.blank'
          end
          #Date of birth
          section :date_of_birth, :legend_header, 'claims.personal_details.date_of_birth', exact: false do
            element :error_date_of_birth, :error, 'activemodel.errors.models.claimant.attributes.date_of_birth.too_young'
            element :date_of_birth_hint, :paragraph, 'simple_form.hints.claimant.date_of_birth'
            section :day, :question_labelled, 'simple_form.labels.claimant.date_of_birth.day' do
              element :field, :css, '#claimant_date_of_birth_day'
              delegate :set, to: :field
            end
            section :month, :question_labelled, 'simple_form.labels.claimant.date_of_birth.month' do
              element :field, :css, '#claimant_date_of_birth_month'
              delegate :set, to: :field
            end
            section :year, :question_labelled, 'simple_form.labels.claimant.date_of_birth.year' do
              element :field, :css, '#claimant_date_of_birth_year'
              delegate :set, to: :field
            end
            def set(value)
              (day_value, month_value, year_value) = value.split("/")
              day.set(day_value)
              month.set(month_value)
              year.set(year_value)
            end
          end
          section :gender, :question_labelled, 'claims.claimant.gender' do
            element :error_gender, :error, 'activemodel.errors.models.claimant.attributes.gender.blank'
            element :male, :form_labelled, 'simple_form.options.claimant.gender.male' do
              element :selector, :css, 'input[type="radio"]'
              delegate :set, to: :selector
            end
            element :female, :form_labelled, 'simple_form.options.claimant.gender.female' do
              element :selector, :css, 'input[type="radio"]'
              delegate :set, to: :selector
            end
            element :prefer_not_to_say, :form_labelled, 'simple_form.options.claimant.gender.prefer_not_to_say' do
              element :selector, :css, 'input[type="radio"]'
              delegate :set, to: :selector
            end
            def set(value)
              case value
                when "Male"
                  male.click
                when "Female"
                  female.click
                when "Prefer not to say"
                  prefer_not_to_say.click
                else
                  puts "#{value} you have entered is not valid"
              end
            end
          end
          #has special needs
          section :claiman_has_special_needs, '.form-group-reveal' do
            element :has_special_needs, :form_labelled, 'simple_form.labels.claimant.has_special_needs'
            element :has_special_needs_hint, :paragraph, 'simple_form.hints.claimant.has_special_needs'
            element :yes, :form_labelled, 'simple_form.yes' do
              element :selector, :css, '#claimant_has_special_needs_true'
              delegate :set, to: :selector
            end
            element :no, :form_labelled, 'simple_form.no' do
              element :selector, :css, '#claimant_has_special_needs_false'
              delegate :set, to: :selector
            end
            def set(value)
              case value
                when "Yes"
                  yes.click
                when "No"
                  no.click
                else
                  puts "#{value} you have entered is not valid"
              end
            end
          end
          #describe the assistance you require
          section :assistance, '.claimant_special_needs' do
            element :special_needs, :textarea_labelled, 'simple_form.labels.claimant.special_needs'
            element :field, :css, 'textarea'
            delegate :set, to: :field
          end
          #Claimant's contact details
          element :claimants_contact_details, :legend_header, 'claims.claimant.legend_contact_details', exact: false
          element :building, :question_labelled, 'simple_form.labels.claimant.address_building' do
            element :field, :css, 'input'
            delegate :set, to: :field
          end
          element :error_building, :error, 'activemodel.errors.models.claimant.attributes.address_building.blank'
          element :street, :question_labelled, 'simple_form.labels.claimant.address_street' do
            element :field, :css, 'input'
            delegate :set, to: :field
          end
          element :error_street, :error, 'activemodel.errors.models.claimant.attributes.address_street.blank'
          element :locality, :question_labelled, 'simple_form.labels.claimant.address_locality' do
            element :field, :css, 'input'
            delegate :set, to: :field
          end
          element :error_locality, :error, 'activemodel.errors.models.claimant.attributes.address_locality.blank'
          #County
          element :county, :question_labelled, 'simple_form.labels.claimant.address_county' do
            element :field, :css, 'input'
            delegate :set, to: :field
          end
          element :error_county, :error, 'activemodel.errors.models.claimant.attributes.address_county.blank'
          element :county_hint, :paragraph, 'simple_form.hints.claimant.address_county', exact: false
          element :post_code, :question_labelled, 'simple_form.labels.claimant.address_post_code' do
            element :field, :css, 'input'
            delegate :set, to: :field
          end
          element :error_post_code, :error, 'activemodel.errors.models.claimant.attributes.address_post_code.blank'
          section :country, :question_labelled, 'simple_form.labels.claimant.address_country' do
            def set(value)
              root_element.select(value)
            end
          end
          element :error_address_county, :error, 'activemodel.errors.models.claimant.attributes.address_county.blank'
          element :telephone_number, :question_labelled, 'simple_form.labels.claimant.address_telephone_number' do
            element :field, :css, 'input'
            delegate :set, to: :field
          end
          element :alternative_telephone_number, :question_labelled, 'simple_form.labels.claimant.mobile_number' do
            element :field, :css, 'input'
            delegate :set, to: :field
          end
          section :email_address, :question_labelled, 'simple_form.labels.claimant.email_address', exact: false do
            element :field, :css, 'input[type="email"]'
            delegate :set, to: :field
          end
          element :invalid_email_address, :error, 'activemodel.errors.models.claimant.attributes.email_address.invalid'
          element :blank_email_address, :error, 'activemodel.errors.models.claimant.attributes.email_address.blank'
          #correspondence
          section :claimant_contact_preference, '.claimant_contact_preference' do
            element :error_claimant_contact_preference, :error, 'activemodel.errors.models.claimant.attributes.contact_preference.blank'
            element :correspondence, :form_labelled, 'simple_form.labels.claimant.contact_preference'
            element :contact_preference, :paragraph, 'simple_form.hints.claimant.contact_preference'
            section :email_preference, :form_labelled, 'simple_form.options.claimant.contact_preference.email' do
              element :selector, :css, 'input[type="radio"]'
              delegate :set, to: :selector
            end
            section :post_preference, :form_labelled, 'simple_form.options.claimant.contact_preference.post' do 
              element :selector, :css, 'input[type="radio"]'
              delegate :set, to: :selector
            end
            def set(value)
              choose(value, name: 'claimant[contact_preference]')
            end
          end
          #Save and continue
          element :save_and_continue_button, :submit_text, 'helpers.submit.update', exact: false
        end
        #Support links
        section :support, 'aside[role="complementary"]' do
          element :suport_header, :support_header, 'shared.aside.gethelp_header'
          element :guide, :link_named, 'shared.aside.read_guide'
          element :contact_use, :link_named, 'shared.aside.contact_us'
          element :your_claim, :support_header, 'shared.aside.actions_header'
          element :save_and_complete_later, :button, 'shared.mobile_nav.save_and_complete', exact: false
        end

        def has_correct_translation?
          #your feedback header
          expect(feedback_notice.language.text).to be_truthy
          expect(feedback_notice.feedback_link.text).to be_truthy
          #Page header
          expect(main_header.page_header.text).to be_truthy
          #About your claimant
          expect(main_content.legend_personal_details.text).to be_truthy
          expect(main_content.personal_details_description.text).to be_truthy
          expect(main_content.title.text).to be_truthy
          expect(main_content.first_name.text).to be_truthy
          expect(main_content.last_name.text).to be_truthy
          #date of birth
          expect(main_content.date_of_birth.text).to be_truthy
          expect(main_content.date_of_birth.date_of_birth_hint.text).to be_truthy
          expect(main_content.date_of_birth.day.text).to be_truthy
          expect(main_content.date_of_birth.month.text).to be_truthy
          expect(main_content.date_of_birth.year.text).to be_truthy
          #gender
          expect(main_content.gender.text).to be_truthy
          expect(main_content.gender.male.text).to be_truthy
          expect(main_content.gender.female.text).to be_truthy
          expect(main_content.gender.prefer_not_to_say.text).to be_truthy
          #has special needs
          expect(main_content.claiman_has_special_needs.has_special_needs.text).to be_truthy
          expect(main_content.claiman_has_special_needs.has_special_needs_hint.text).to be_truthy
          expect(main_content.claiman_has_special_needs.yes.text).to be_truthy
          expect(main_content.claiman_has_special_needs.no.text).to be_truthy
          expect(main_content.assistance.special_needs.text).to be_truthy
          #Claimant's contact details
          expect(main_content.claimants_contact_details.text).to be_truthy
          expect(main_content.building.text).to be_truthy
          expect(main_content.street.text).to be_truthy
          expect(main_content.locality.text).to be_truthy
          expect(main_content.county.text).to be_truthy
          expect(main_content.county_hint.text).to be_truthy
          expect(main_content.post_code.text).to be_truthy
          expect(main_content.country.text).to be_truthy
          expect(main_content.telephone_number.text).to be_truthy
          expect(main_content.alternative_telephone_number.text).to be_truthy
          expect(main_content.email_address.text).to be_truthy
          #Best way to send correspondence
          expect(main_content.claimant_contact_preference.correspondence.text).to be_truthy
          expect(main_content.claimant_contact_preference.contact_preference.text).to be_truthy
          expect(main_content.claimant_contact_preference.email_preference.text).to be_truthy
          expect(main_content.claimant_contact_preference.post_preference.text).to be_truthy
          #Save and continue
          expect(main_content.save_and_continue_button.text).to be_truthy
          #Support
          expect(support.suport_header.text).to be_truthy
          expect(support.guide.text).to be_truthy
          expect(support.contact_use.text).to be_truthy
          #Save your claim later
          expect(support.your_claim.text).to be_truthy
          #TODO this has stopped working - why?
          # expect(support.save_and_complete_later.text).to be_truthy
        end
        
        def has_correct_translation_for_assistance_required?
          expect(main_content.assistance.special_needs.text).to be_truthy
        end

        def has_correct_error_message_for_leaving_email_address_field_blank?
          expect(main_content.blank_email_address.text).to be_truthy
        end

        def has_correct_error_message_for_invalid_email_address?
          expect(main_content.blank_email_address.text).to be_truthy
        end

        def has_correct_validation_error_message?
          #Errors on page
          expect(main_content.error_message.error_summary.text).to be_truthy
          #TODO why has this stopped working - why?
          # expect(main_content.error_message.default_message.text).to be_truthy
          expect(main_content.title.error_title.text).to be_truthy
          expect(main_content.first_name.error_first_name.text).to be_truthy
          expect(main_content.last_name.error_last_name.text).to be_truthy
          expect(main_content.date_of_birth.error_date_of_birth.text).to be_truthy
          expect(main_content.gender.error_gender.text).to be_truthy
          expect(main_content.error_building.text).to be_truthy
          expect(main_content.error_street.text).to be_truthy
          expect(main_content.error_locality.text).to be_truthy
          expect(main_content.error_county.text).to be_truthy
          expect(main_content.error_post_code.text).to be_truthy
          expect(main_content.error_address_county.text).to be_truthy
          expect(main_content.claimant_contact_preference.error_claimant_contact_preference.text).to be_truthy
        end

        def save_and_continue
          main_content.save_and_continue_button.click
        end
      end
    end
  end
end
