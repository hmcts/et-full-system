# TODO: Refactor so as not to use CSS selectors
require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class FormSubmissionPage < BasePage
        include RSpec::Matchers
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :govuk_link, :'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        element :header, :main_header, 'submission.confirmation'
        element :submission_confirmation, :element_with_text, 'submission.confirmation'
        element :reference_number, :summary_list_row_labelled, 'submission.reference_number'
        element :thank_you, :element_with_text, 'submission.thank_you'
        element :office_contact, :element_with_text, 'submission.office_contact'
        element :submission_date, :summary_list_row_labelled, 'submission.date'
        element :valid_pdf_download, :govuk_link, :'links.form_submission.valid_pdf_download'
        element :invalid_pdf_download, :govuk_link, :'links.form_submission.invalid_pdf_download'
        element :return_to_govuk_button, :govuk_link, :'submission.return_link'
        def return
          return_to_govuk_button.click
        end

        def switch_to_welsh
          switch_language.welsh_link.click
        end

        def switch_to_english
          switch_language.english_link.click
        end

        def assert_valid_submission_date(date)
          month = t('date.month_names')[date.month]

          within submission_date do 
            expect(page).to have_selector '.govuk-summary-list__value', text: date.strftime("%-d #{month} %Y")
          end
        end
      end
    end
  end
end
