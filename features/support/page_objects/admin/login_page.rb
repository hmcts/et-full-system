module EtFullSystem
  module Test
    module Admin
      class LoginPage < Admin::BasePage
        set_url "/login"
        element :username_field, :field, 'Username*'
        element :password_field, :field, 'Password*'
        element :login_button, 'input[value=Login]'

        def login(username: admin_username, password: admin_password)
          username_field.set(username)
          password_field.set(password)
          login_button.click
        end

        private

        def admin_username
          ::EtFullSystem::Test::Configuration.admin_username
        end

        def admin_password
          ::EtFullSystem::Test::Configuration.admin_password
        end
      end
    end
  end
end