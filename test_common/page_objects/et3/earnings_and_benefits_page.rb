require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class EarningsAndBenefitsPage < BasePage
        include RSpec::Matchers
        include EtTestHelpers::Page
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        # Earnings and Benefits
        element :header, :content_header, 'earnings_and_benefits.header'
        section :main_header, '.content-header' do

        end
        element :error_header, :error_titled, 'errors.header', exact: true
        gds_radios :agree_with_claimants_hours_question, :'questions.agree_with_claimants_hours', exact: false
        gds_text_input :queried_hours, :'questions.queried_hours', exact: false
        gds_radios :agree_with_earnings_details_question, :'questions.agree_with_earnings_details', exact: false
        gds_text_input :queried_pay_before_tax, :'questions.queried_pay_before_tax', exact: true
        gds_radios :queried_pay_before_tax_period, :'questions.queried_pay_before_tax_period'
        gds_text_input :queried_take_home_pay, :'questions.queried_take_home_pay'
        gds_radios :queried_take_home_pay_period, :'questions.queried_take_home_pay_period'
        gds_radios :agree_with_claimant_notice_question, :'questions.agree_with_claimant_notice', exact: false
        gds_text_area :disagree_claimant_notice_reason, :'questions..disagree_claimant_notice_reason', exact: false
        gds_radios :agree_with_claimant_pension_benefits_question, :'questions.agree_with_claimant_pension_benefits', exact: false
        gds_text_area :disagree_claimant_pension_benefits_reason, :'questions.disagree_claimant_pension_benefits_reason', exact: false
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
