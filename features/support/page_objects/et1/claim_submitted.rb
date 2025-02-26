require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class ClaimSubmitted < BasePage
        include RSpec::Matchers
        # Claim submitted
        element :page_header, :page_title, 'claim_confirmations.show.header', exact: false
        # What happens next
        element :what_happens_next, :content_header, 'claim_confirmations.show.what_happens_next.header'
        section :numerical_list, '.govuk-list' do
          element :send_to_respondent, :paragraph, 'claim_confirmations.show.what_happens_next.content',
                  exact: false
          # We'll check your claim and may contact you if we have any questions
          # We'll contact you once we've sent your claim to the respondents and explain what happens next
        end
        # Submission details
        section :submission_details, :css, '.submission-details' do
          # Submission reference
          section :submission_reference, :css, '.govuk-summary-list__row:nth-of-type(1)' do
            # Your claim number
            element :claim_number, :css, '.govuk-summary-list__value'
          end
          # Claim submitted
          section :submission_information, :css,
                  'claim_confirmations.show.submission_details.submission_information' do
            element :answer, :css, '.govuk-summary-list__value'
          end
          # Download your claim
          section :download_application, :grid_row_with_col_labelled,
                  'claim_confirmations.show.download_application.header' do
            element :download_application_link, :govuk_link, :'claim_confirmations.show.download_application.link_text'
            element :download_application_invalid_link, :govuk_link, :'claim_confirmations.show.download_application.invalid_link_text'
          end
          # Attachments included
          section :attachments, :grid_row_with_col_labelled,
                  'claim_confirmations.show.submission_details.attachments' do
            element :answer, :css, '.govuk-summary-list__value'
          end
        end
        # For questions about your claim
        section :office_information, :css, '.office_information' do
          # Tribunal office
          element :tribunal_office, :css, '.govuk-summary-list__value:nth-of-type(1)'
          element :email , :css, '.govuk-summary-list__value:nth-of-type(2)'
          element :telephone, :css, '.govuk-summary-list__value:nth-of-type(3)'
        end

        # For questions about the employment tribunal process
        element :process_questions, :grid_row_with_col_labelled, 'claim_confirmations.show.process_questions'
        element :process_questions_content, :paragraph, 'claim_confirmations.show.process_questions_content', exact: false
        element :eng_telephone_number, :paragraph, 'claim_confirmations.show.eng_telephone_number'
        element :wel_telephone_number, :paragraph, 'claim_confirmations.show.wel_telephone_number'
        element :sco_telephone_number, :paragraph, 'claim_confirmations.show.sco_telephone_number'

        element :print_this_page, :govuk_link, :'claim_confirmations.show.print_link_html'
        element :for_your_record, :paragraph, 'claim_confirmations.show.print_link_info', exact: false
        element :your_feedback, :govuk_link, :'claim_confirmations.show.feedback_html'
        element :your_feedback_info, :paragraph, 'claim_confirmations.show.feedback_info', exact: false
        element :diversity_info, :paragraph, 'claim_confirmations.show.diversity_html', exact: false
        element :diversity_link_element, :govuk_link, :'claim_confirmations.show.diversity_link'

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
          expect(submission_reference).to have_claim_number
          expect(submission_reference).to have_answer(text: claim_number)
          # What happens next
          expect(self).to have_what_happens_next
          expect(numerical_list).to have_send_to_respondent
          expect(numerical_list).to have_next_steps
          # Submission details
          expect(self).to have_submission_details
          # Down your claim
          expect(submission_details).to have_download_application
          expect(submission_details.download_application).to have_download_application_link.or have_download_application_invalid_link
          # Claim submitted
          expect(has_forwarded_to_local_office?(office)).to be true
          # attachment
          expect(has_attachment?(rtf_attachment, csv_attachment)).to be true
          # Print this page
          expect(self).to have_print_this_page
          expect(self).to have_for_your_record
          # Your feedback
          expect(self).to have_your_feedback
          expect(self).to have_your_feedback_info
          # Helps us keep track
          expect(self).to have_diversity_info
          expect(self).to have_diversity_info
        end

        def has_forwarded_to_local_office?(office)
          raise ArgumentError, 'office is nil' if office.nil?

          expect(submission_details).to have_submission_information
          office_text = "#{office[:name]}, #{office[:email]}, #{office[:telephone]}"
          expect(submission_details.tribunal_office).to have_answer(text: office_text)
          date = Time.now
          expect(submission_details.submission_information.answer.text).to eq(t(
                                                                                'claim_confirmations.show.submission_details.submission_date', date: date.strftime("%d #{t('date.month_names')[date.month]} %Y")
                                                                              ))
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
          submission_details.submission_reference.claim_number.text
        end
      end
    end
  end
end
