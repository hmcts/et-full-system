require 'rspec/matchers'
module EtFullSystem
  module Test
    module Admin
      class NewUserPage < Admin::BasePage
        element :success_message, 'div.flash.flash_notice'
        element :name, 'input[name="admin_user[name]"]'
        element :email, 'input[name="admin_user[email]"]'
        element :username, 'input[name="admin_user[username]"]'
        element :username_error, '#admin_user_username_input .inline-errors'
        element :department, 'select[name="admin_user[department]"]'
        element :password, 'input[name="admin_user[password]"]'
        element :confirm_password, 'input[name="admin_user[password_confirmation]"]'
        element :password, 'input[name="admin_user[password]"]'
        element :department_selection_field, '#admin_user_department_input > span > span.selection > span'
        element :role_selection_field, '#admin_user_role_ids_input > span > span.selection > span'
        section :drop_downList, '.select2-dropdown' do
          element :selection, '.select2-results ul li'
        end
        element :create_user_button, 'fieldset.actions input[value="Create User"]'
        element :cancel_button, 'fieldset.actions a[href="/admin/users"]'

        def add_new_user(user)
          name.set(user[:name])
          email.set("#{user[:email]}@blah.com")
          username.set(user[:username])
          department_selection_field.click
          drop_downList.selection(text: user[:department]).click
          password.set(user[:password])
          confirm_password.set(user[:password])
          role_selection_field.click
          drop_downList.selection(text: user[:role]).click
          sleep 0.1
          create_user_button.click
        end

        def has_successfully_created?
          expect(success_message).to have_content("User was successfully created.")
        end
      end
    end
  end
end

# <span class="select2 select2-container select2-container--default select2-container--below select2-container--focus" dir="ltr" data-select2-id="1" style="width: 80%;"><span class="selection"><span class="select2-selection select2-selection--multiple" role="combobox" aria-haspopup="true" aria-expanded="false" tabindex="-1" aria-disabled="false"><ul class="select2-selection__rendered"><span class="select2-selection__clear" title="Remove all items" data-select2-id="16">×</span><li class="select2-selection__choice" title="Admin" data-select2-id="14"><span class="select2-selection__choice__remove" role="presentation">×</span>Admin</li><li class="select2-selection__choice" title="Developer" data-select2-id="15"><span class="select2-selection__choice__remove" role="presentation">×</span>Developer</li><li class="select2-search select2-search--inline"><input class="select2-search__field" type="search" tabindex="0" autocomplete="off" autocorrect="off" autocapitalize="none" spellcheck="false" role="searchbox" aria-autocomplete="list" placeholder="" style="width: 0.75em;"></li></ul></span></span><span class="dropdown-wrapper" aria-hidden="true"></span></span>
#