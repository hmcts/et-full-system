require_relative './base_page'
require_relative '../../../test_common/helpers/upload_helper'
module EtFullSystem
  module Test
    module Et3
      class AdditionalInformationPage < BasePage
        include EtTestHelpers::Page
        include ::EtFullSystem::Test::UploadHelper
        include RSpec::Matchers
        set_url '/respond/additional_information'
        section :switch_language, '.switch-language' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
        end
        element :header, :content_header, "additional_information.header"
        section :main_header, '.content-header' do

        end
        element :error_header, :error_titled, 'errors.header', exact: true
        gds_file_dropzone_upload :upload_additional_information_question, :'questions.upload_additional_information'
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

        def attach_additional_information_file(respondent)
          data = respondent.to_h
          return if respondent.nil?
          if data.key?(:rtf_file)
            force_remote do
              upload_additional_information_question.set(File.expand_path(File.join('test_common', 'fixtures', data[:rtf_file])))
            end
          end
          page.has_content?('Remove file')
        end
      end
    end
  end
end
