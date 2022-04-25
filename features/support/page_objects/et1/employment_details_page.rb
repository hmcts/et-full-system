require_relative './base_page'
module EtFullSystem
  module Test
    module Et1
      class EmploymentDetailsPage < BasePage
        include RSpec::Matchers
        # Employment details
        element :page_header, :page_title, 'claims.employment.header', exact: false
        # @!method error_summary
        #   A govuk error component
        #   @return [EtTestHelpers::Components::GovUKErrorSummary] The site prism section
        gds_error_summary :error_summary, :'shared.error_notification.default_message'
        # Your employment details
        element :your_employment_details_header, :legend_header, 'claims.employment.situation_legend'
        # @!method your_employment_details
        #   A govuk radio button component for your_employment_details question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
        gds_radios :your_employment_details, :'simple_form.labels.employment.was_employed'
        # What is your current work situation in relation to the employer you're making a claim against?
        element :current_work_situation_labelled, :legend_header, 'claims.employment.current_situation', exact: false
        # @!method employment_current_situation
        #   A govuk radio button component for employment_current_situation question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
        gds_radios :employment_current_situation, :'claims.employment.current_situation'
        # Employment details
        element :employment_details_header, :legend_header, 'claims.employment.situation_legend'

        # @!method employment_job_title
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :employment_job_title, :'simple_form.labels.employment.job_title'

        # @!method employment_start_date
        #   A govuk date field component wrapping the inputs, label, hint etc.. for a date question
        #   @return [EtTestHelpers::Components::GovUKDateField] The site prism section
        gds_date_input :employment_start_date, :'claims.employment.start_date'
        # Notice period end date
        # @!method notice_period
        #   A govuk date field component wrapping the inputs, label, hint etc.. for a date question
        #   @return [EtTestHelpers::Components::GovUKDateField] The site prism section
        gds_date_input :notice_period, :'claims.employment.notice_period_end_date'
        # Employment end date
        # @!method employment_end_date
        #   A govuk date field component wrapping the inputs, label, hint etc.. for a date question
        #   @return [EtTestHelpers::Components::GovUKDateField] The site prism section
        gds_date_input :employment_end_date, :'claims.employment.end_date'
        # @!method worked_notice_period_or_paid_in_lieu_question
        #   A govuk radio button component for 'Did you work (or get paid for) a period of notice?' question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
        gds_radios :worked_notice_period_or_paid_in_lieu, :'claims.employment.worked_notice_period_or_paid_in_lieu'
        # For how many weeks or months did you get paid? (optional)
        # @!method notice_period_value
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :notice_period_value, :'simple_form.labels.employment.notice_pay_period_count'

        # @!method employment_notice_pay_period_type
        #   A govuk radio button component for employment_notice_pay_period_type question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
        gds_radios :employment_notice_pay_period_type, :'simple_form.labels.employment.notice_pay_period_type'

        # @!method employment_average_hours_worked_per_week
        #   A govuk text field component for the 'Average hours worked per week (optional)' question
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :employment_average_hours_worked_per_week,
                       :'simple_form.labels.employment.average_hours_worked_per_week'
        # Pay, pension and benefits
        element :pay_pension_benefits, :legend_header, 'claims.employment.pay_legend'
        # @!method employment_pay_period_type
        #   A govuk radio button component for pay_period_type question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
        gds_radios :employment_pay_period_type, :'review.employment.questions.pay_period_type.label'

        # Pay before tax (optional)
        # @!method employment_gross_pay
        #   A govuk text field component wrapping the input, label, hint etc..
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :employment_gross_pay, :'simple_form.labels.employment.gross_pay'

        # @!method employment_net_pay
        #   A govuk text field component for the 'Pay after tax (optional)' question
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :employment_net_pay, :'simple_form.labels.employment.net_pay'

        # @!method employment_enrolled_in_pension_scheme
        #   A govuk radio button component for 'Are – or were – you a member of your employer’s pension scheme? (optional)' question
        #   @return [EtTestHelpers::Components::GovUKCollectionRadioButtons] The site prism section
        gds_radios :employment_enrolled_in_pension_scheme, :'simple_form.labels.employment.enrolled_in_pension_scheme'
        # Do – or did – you have any benefits, like a company car? (optional)
        # @!method employment_benefit_details
        #   A govuk text area component wrapping the input, label, hint etc.. for a text area
        #   @return [EtTestHelpers::Components::GovUKTextArea] The site prism section
        gds_text_area :employment_benefit_details, :'simple_form.labels.employment.benefit_details'
        # New Job

        gds_radios :new_job, :'simple_form.labels.employment.found_new_job'

        # New Job start date
        # @!method employment_end_date
        #   A govuk date field component wrapping the inputs, label, hint etc.. for a date question
        #   @return [EtTestHelpers::Components::GovUKDateField] The site prism section
        gds_date_input :new_job_start_date, :'claims.employment.new_job_start_date'

        gds_radios :new_job_pay_before_tax_type, :'claims.employment.new_job_pay_before_tax_type'

        # @!method new_job_pay_before_tax
        #   A govuk text field component for the 'New job pay before tax' question
        #   @return [EtTestHelpers::Components::GovUKTextField] The site prism section
        gds_text_input :new_job_pay_before_tax, :'simple_form.labels.employment.new_job_gross_pay'

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
          # Employment details
          expect(self).to have_page_header
          # Your employment details
          expect(self).to have_your_employment_details_header
          # Have you ever been employed by the person or organisation that you’re making this claim against? (optional)
          your_employment_details.assert_valid_options
          # What is your current work situation in relation to the employer you're making a claim against?
          employment_current_situation.assert_valid_options
          # Employment details
          expect(self).to have_employment_details_header
          # Job title (optional)
          expect(employment_job_title).to have_hint(text: t('simple_form.hints.employment.job_title'))
          # Employment start date
          expect(employment_start_date).to have_hint(text: t('simple_form.hints.employment.start_date'))
          expect(employment_start_date).to be_valid
          # Employment end date
          expect(employment_end_date).to have_hint(text: t('simple_form.hints.employment.end_date'))
          # Did you work (or get paid for) a period of notice?
          worked_notice_period_or_paid_in_lieu.assert_valid_options
          # For how many weeks or months did you get paid? (optional)
          expect(self).to have_notice_period_value
          employment_notice_pay_period_type.assert_valid_options
          # Average hours worked per week (optional)
          expect(employment_average_hours_worked_per_week).to have_hint(text: t('simple_form.hints.employment.average_hours_worked_per_week'))
          # Pay, pension and benefits
          expect(self).to have_pay_pension_benefits
          # How often were you paid (optional)
          expect(self).to have_employment_pay_period_type
          # Pay before tax (optional)
          expect(self).to have_employment_gross_pay
          expect(employment_gross_pay).to have_hint(text: t('simple_form.hints.employment.gross_pay'))
          # Pay after tax (optional)
          expect(self).to have_employment_net_pay
          expect(employment_net_pay).to have_hint(text: t('simple_form.hints.employment.net_pay'))
          # Are – or were – you a member of your employer’s pension scheme? (optional)
          expect(self).to have_employment_enrolled_in_pension_scheme
          employment_enrolled_in_pension_scheme.assert_valid_options
          # Do – or did – you have any benefits, like a company car? (optional)
          expect(self).to have_employment_benefit_details
          expect(employment_benefit_details).to have_hint(text: t('simple_form.hints.employment.benefit_details'))
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

        def has_correct_error_message_for_current_work_situation?
          expect(self).to have_error_summary
          expect(employment_current_situation).to have_error(text: t('activemodel.errors.models.employment.attributes.current_situation.blank'))
        end

        def has_correct_invalid_date_error_messages?
          expect(self).to have_error_summary
          expect(employment_start_date).to have_error(text: t('activemodel.errors.models.employment.attributes.start_date.invalid'))
          # expect(employment_notice_period_end_date).to have_invalid_employment_end_date
        end

        def set(employment)
          data = employment.to_h
          if data[:employment_details] == :"claims.employment.yes"

            your_employment_details.set(data[:employment_details])
            employment_current_situation.set(data[:current_work_situation])
            employment_job_title.set(data[:job_title])
            employment_start_date.set(data[:start_date])

            if data[:current_work_situation] == :"simple_form.options.employment.current_situation.notice_period"
              notice_period.set(data[:notice_period_end_date])
            end
            if data[:current_work_situation] == :"simple_form.options.employment.current_situation.employment_terminated"
              employment_end_date.set(data[:end_date])
            end
            if data[:paid_for_notice_period] == :"claims.employment.paid_for_notice_period.yes"
              worked_notice_period_or_paid_in_lieu.set(data[:paid_for_notice_period])
              notice_period_value.set(data[:notice_period])
              employment_notice_pay_period_type.set(data[:notice_period_type])
            elsif data[:paid_for_notice_period] == :"claims.employment.paid_for_notice_period.no"
              worked_notice_period_or_paid_in_lieu.set(data[:paid_for_notice_period])
            end
            employment_average_hours_worked_per_week.set(data[:average_weekly_hours])
            employment_pay_period_type.set(data[:pay_period_type])
            employment_gross_pay.set(data[:pay_before_tax])
            employment_net_pay.set(data[:pay_after_tax])
            employment_enrolled_in_pension_scheme.set(data[:employers_pension_scheme])
            employment_benefit_details.set(data[:benefits])

            if data[:new_job] == :"claims.employment.new_job.yes"
              new_job.set(data[:new_job])
              new_job_start_date.set(data[:new_job_start_date])
              new_job_pay_before_tax.set(data[:new_job_pay_before_tax])
              new_job_pay_before_tax_type.set(data[:new_job_pay_before_tax_type])
            end

          else
            your_employment_details.set(:"claims.employment.no")
          end
        end
      end
    end
  end
end
