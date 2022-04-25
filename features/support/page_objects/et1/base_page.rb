module EtFullSystem
  module Test
    module Et1
      class BasePage < ::EtFullSystem::Test::BasePage
        #your feedback header
        section :cookie, '.govuk-cookie-banner' do
          include EtTestHelpers::Section
          element :header, :cookie_banner_heading, :'banner.title'
          gds_submit_button :accept_button, :'banner.accept_analytics'
          gds_submit_button :reject_button, :'banner.reject_analytics'
          element :cookies, :link_named, 'banner.cookie_link'
        end

        section :feedback_notice, '.govuk-phase-banner' do
          include ::EtFullSystem::Test::I18n
          element :language, :link_named, 'switch.language'
          element :welsh_link, :link_or_button, t('switch.language', locale: :en)
          element :english_link, :link_or_button, t('switch.language', locale: :cy)
          element :feedback_link, :link_named, 'shared.feedback_link'
          element :feedback_info, :paragraph, 'shared.feedback_statement_html', exact: false
        end

        #Support links
        section :support, 'aside[role="complementary"]' do
          element :suport_header, :support_header, 'shared.aside.gethelp_header'
          element :guide, :link_named, 'shared.aside.read_guide'
          element :contact_use, :link_named, 'shared.aside.contact_us'
          element :your_claim, :support_header, 'shared.aside.actions_header'
          element :save_and_complete_later, :button, 'shared.mobile_nav.save_and_complete'
        end
      end
    end
  end
end
