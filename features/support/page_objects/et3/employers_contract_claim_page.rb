require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class EmployersContractClaimPage < BasePage
        include RSpec::Matchers
        include EtTestHelpers::Page
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :govuk_link, :'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        element :header, :content_header, 'employer_contract_claim.header'
        section :main_header, '.content-header' do

        end
        gds_radios :make_employer_contract_claim_question, :'questions.make_employer_contract_claim', exact: true
        gds_text_area :claim_information, :'questions.claim_information', exact: true
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
