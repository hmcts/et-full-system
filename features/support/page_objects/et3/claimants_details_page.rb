require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class ClaimantsDetailsPage < BasePage
        include RSpec::Matchers
        include EtTestHelpers::Page
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :govuk_link, :'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        # Claimant Details Details
        element :header, :content_header, 'claimants_details.header'
        section :main_header, '.content-header' do

        end
        section :error_summary, '.error-summary[aria-labelledby="error-summary-heading"]' do
          element :error_heading, :main_header, 'errors.header'
          element :description, :paragraph, 'errors.description'
        end

        gds_text_input :claimants_name_question, :'questions.claimants_name', exact: false
        # Do you agree with the details given by the claimant about Early Conciliation with Acas? (optional)
        gds_radios :agree_with_early_conciliation_details_question, :'questions.agree_with_early_conciliation_details', exact: false
        gds_text_area :disagree_conciliation_reason, :'questions.disagree_conciliation_reason', exact: false

        gds_radios :agree_with_employment_dates_question, :'questions.agree_with_employment_dates', exact: false
        gds_date_input :employment_start, :'questions.employment_start', exact: false
        gds_date_input :employment_end, :'questions.employment_end', exact: false
        gds_text_area :disagree_employment, :'questions.disagree_employment', exact: false

        # Is their employment continuing? (optional)
        gds_radios :continued_employment_question, :'questions.continued_employment', exact: false
        # Is the claimant's description of their job or job title correct? (optional)
        gds_radios :agree_with_claimants_description_of_job_or_title_question, :'questions.agree_with_claimants_description_of_job_or_title', exact: false
        gds_text_area :disagree_claimants_job_or_title, :'questions.disagree_claimants_job_or_title', exact: false
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

        def has_correct_translation?
          # Claimants's Details
          expect(self).to have_header
          # Claimant's name (optional)
          expect(self).to have_claimants_name_question
          # Do you agree with the details given by the claimant about Early Conciliation with Acas? (optional)
          expect(self).to have_agree_with_early_conciliation_details_question
          # Why do you disagree with the claimant? (optional)
          expect(self).to have_disagree_conciliation_reason
          # Are the dates of employment given by the claimant correct?
          expect(self).to have_agree_with_employment_dates_question
          # For example, 31 03 2010
          expect(employment_start).to have_hint
          # When their employment ended or will end
          expect(self).to have_employment_end
          # For example, 01 12 2017
          expect(employment_end).to have_hint
          # Why do you disagree with the dates given by the claimant
          expect(self).to have_disagree_employment
          # Is their employment continuing? (optional)
          expect(self).to have_continued_employment_question
          # Is the claimant's description of their job or job title correct? (optional
          expect(self).to have_agree_with_claimants_description_of_job_or_title_question
          # Please give the details you believe to be correct (optional)
          expect(self).to have_disagree_claimants_job_or_title
        end
      end
    end
  end
end
