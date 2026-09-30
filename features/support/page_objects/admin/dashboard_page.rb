module EtFullSystem
  module Test
    module Admin
      class DashboardPage < Admin::BasePage
        include EtFullSystem::Test::Admin
        set_url ''

        def admin_login(username, password)
          admin_pages.logout_page.load
          return unless admin_pages.login_page.displayed?

          admin_pages.login_page.login(username: username, password: password)
          return if admin_pages.dashboard_page.displayed?

          raise "Could not login to admin with username '#{username}' and password '#{password}'"
        end
      end
    end
  end
end
