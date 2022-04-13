require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class DisabilityPage < BasePage
        include RSpec::Matchers
        include EtTestHelpers::Page
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        element :header, :content_header, 'disability.header'
        section :main_header, '.content-header' do

        end
        gds_error_summary :error_summary, :'errors.header'
        element :error_header, :error_titled, 'errors.header', exact: true
        gds_radios :disability_question, :'questions.disability', exact: false
        gds_text_area :disability_information, :'questions.disability_information', exact: :false

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
