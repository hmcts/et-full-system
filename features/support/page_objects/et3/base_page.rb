module EtFullSystem
  module Test
    module Et3
      class BasePage < ::SitePrism::Page
        include EtFullSystem::Test::I18n
        section :sidebar, :sidebar_titled, 'components.sidebar.header' do
          element :claim_link, :govuk_link, :'components.sidebar.claim_link'
          element :response_link, :govuk_link, :'components.sidebar.response_link'
          element :help_fees_link, :govuk_link, :'components.sidebar.help_fees_link'
          element :contact_link, :govuk_link, :'components.sidebar.contact_link'
          element :download_link, :govuk_link, :'components.sidebar.download_link'
          element :more_category_link, :govuk_link, :'components.sidebar.more_category_link'
        end
      end
    end
  end
end
