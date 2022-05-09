require_relative './base_page'
module EtFullSystem
  module Test
    module Et3
      class YourRepresentativePage < BasePage
        include RSpec::Matchers
        include EtTestHelpers::Page
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :govuk_link, :'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        # Your representative page
        element :header, :content_header, 'questions.have_representative.title'
        section :main_header, '.content-header' do

        end
        element :header, :content_header, 'questions.have_representative.title'
        gds_radios :representative_question, :'questions.have_representative', exact: true
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
