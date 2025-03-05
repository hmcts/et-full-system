require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class ClaimSubmitted < BasePage
        include RSpec::Matchers
        # Claim submitted
        element :page_header, :css, 'h1.govuk-panel__title'
        # What happens next
        element :what_happens_next, :css, 'h2.govuk-heading-m'
        section :numerical_list, :css, '.govuk-list--bullet' do
          # We'll check your claim and may contact you if we have any questions
          element :send_to_respondent_1, :css, 'li:nth-of-type(1)'
          # We'll contact you once we've sent your claim to the respondents and explain what happens next
          element :send_to_respondent_2, :css, 'li:nth-of-type(2)'
        end
        # Submission details
        section :submission_details, :css, '.submission-details' do
          # Submission reference
          section :submission_reference, :css, '.govuk-summary-list__row:nth-of-type(1)' do
            # Your claim number
            element :answer, :css, '.govuk-summary-list__value'
          end
          # Claim submitted
          section :submission_information, :css, '.govuk-summary-list__row:nth-of-type(2)' do
            element :answer, :css, '.govuk-summary-list__value'
          end
          # Download your claim
          section :download_application, :css, '.govuk-summary-list__row:nth-of-type(3)' do
            element :download_application_link, :css, 'a.pdf-success'
            element :download_application_link_failure, :css, 'a.pdf-failure'
          end
          # Attachments included
          section :attachments, :css, '.govuk-summary-list__row:nth-of-type(4)' do
            element :answer, :css, '.govuk-summary-list__value'
          end
        end
        # For questions about your claim
        section :office_information, :css, '.office-information' do
          # Tribunal office
          element :tribunal_office, :css, '.govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value'
          element :email, :css, '.govuk-summary-list__row:nth-of-type(2) .govuk-summary-list__value'
          element :telephone, :css, '.govuk-summary-list__row:nth-of-type(3) .govuk-summary-list__value'
        end

        # For questions about the employment tribunal process
        element :process_questions, :css, 'h2.govuk-heading-m:nth-of-type(2)'
        element :process_questions_content, :css, 'p.govuk-body:nth-of-type(1)'
        element :eng_telephone_number, :css, 'p.govuk-body:nth-of-type(2)'
        element :wel_telephone_number, :css, 'p.govuk-body:nth-of-type(3)'
        element :sco_telephone_number, :css, 'p.govuk-body:nth-of-type(4)'

        element :print_this_page, :css, 'p.govuk-body:nth-of-type(5) a.govuk-link'
        element :your_feedback, :css, 'p.govuk-body:nth-of-type(6) a.govuk-link'
        element :diversity_info, :css, 'p.govuk-body:nth-of-type(7)'
        element :diversity_link_element, :css, 'p.govuk-body:nth-of-type(7) a.govuk-link'

        def diversity_link
          diversity_link_element.click
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def has_correct_translation?(claim_number, rtf_attachment, csv_attachment, office)
          # your feedback header
          expect(feedback_notice).to have_language
          expect(feedback_notice).to have_feedback_link
          expect(feedback_notice).to have_feedback_info
          # Claim submitted
          expect(self).to have_page_header
          # Your claim number
          expect(submission_details.submission_reference).to have_answer
          expect(submission_details.submission_reference).to have_answer(text: claim_number)
          # What happens next
          expect(self).to have_what_happens_next
          expect(numerical_list).to have_send_to_respondent_1
          expect(numerical_list).to have_send_to_respondent_2
          # Submission details
          expect(self).to have_submission_details
          # Download your claim
          expect(submission_details.download_application).to have_download_application_link.or have_download_application_link_failure
          # Claim submitted
          expect(has_forwarded_to_local_office?(office)).to be true
          # attachment
          expect(has_attachment?(rtf_attachment, csv_attachment)).to be true
          # Print this page
          expect(self).to have_print_this_page
          expect(self).to have_your_feedback
          expect(self).to have_diversity_info
        end

        def has_forwarded_to_local_office?(office)
          raise ArgumentError, 'office is nil' if office.nil?
          expect(submission_details).to have_submission_information
          office_text = "#{office[:name]}, #{office[:email]}, #{office[:telephone]}"
          expect(office_information.tribunal_office).to have_text(office[:name])
          expect(office_information.email).to have_text(office[:email])
          expect(office_information.telephone).to have_text(office[:telephone])
          date = Time.now
          expect(submission_details.submission_information.answer.text).to eq("#{date.strftime("%d #{t('date.month_names')[date.month]} %Y")}")
        end

        def has_attachment?(rtf_attachment, csv_attachment)
          expect(submission_details).to have_attachments
          if !rtf_attachment.nil? && !csv_attachment.nil?
            # Attachments included rtf and csv
            expect(submission_details.attachments.answer.text.tr("\n",
                                                                 '')).to eq("#{rtf_attachment}#{csv_attachment}")
          elsif !rtf_attachment.nil? && csv_attachment.nil?
            # rtf only
            expect(submission_details.attachments).to have_answer(text: rtf_attachment)
          elsif !csv_attachment.nil? && rtf_attachment.nil?
            # csv only
            expect(submission_details.attachments).to have_answer(text: csv_attachment)
          else
            # no attachments
            expect(submission_details.attachments).to have_answer(text: t('claim_confirmations.show.no_attachments'))
          end
        end

        def claim_number
          submission_details.submission_reference.answer.text
        end
      end
    end
  end
end