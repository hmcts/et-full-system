Then(/^load User page$/) do
  admin_pages.any_page.menu.click_users
end

When("a new user is created with {string} role") do |string|
  @user = build(:users, role: string)
  admin_pages.users_page.click_new_user
  admin_pages.new_user_page.add_new_user(@user)
  admin_pages.new_user_page.has_successfully_created?
end

Then("they should be able to login") do
  admin_pages.any_page.utility_nav.click_logout
  admin_pages.dashboard_page.admin_login(@user[:username], @user[:password])
end

Then("have basic access to ET admin system") do
  tab_names = admin_pages.any_page.basic_access
  expect(admin_pages.any_page.names.map { |x| x.text }).to match_array(tab_names)

  # Tear down
  admin_username = ::EtFullSystem::Test::Configuration.admin_username
  admin_password = ::EtFullSystem::Test::Configuration.admin_password
  admin_pages.dashboard_page.admin_login(admin_username, admin_password)
  admin_pages.any_page.menu.click_users
  admin_pages.users_page.delete_user_from_admin("#{@user[:email]}@blah.com")
end

Then("have partial access to ET system") do
  tab_names = admin_pages.any_page.partial_access
  tab_names[tab_names.index('Logout') - 1] = @user[:name]
  expect(admin_pages.any_page.names.map { |x| x.text }).to match_array(tab_names)

  # Tear down
  admin_username = ::EtFullSystem::Test::Configuration.admin_username
  admin_password = ::EtFullSystem::Test::Configuration.admin_password
  admin_pages.dashboard_page.admin_login(admin_username, admin_password)
  admin_pages.any_page.menu.click_users
  admin_pages.users_page.delete_user_from_admin("#{@user[:email]}@blah.com")
end

Then("have full access to ET admin system") do
  tab_names = admin_pages.any_page.full_access
  tab_names[tab_names.index('Logout') - 1] = @user[:name]
  expect(admin_pages.any_page.names.map { |x| x.text }).to match_array(tab_names)

  # Tear down
  admin_username = ::EtFullSystem::Test::Configuration.admin_username
  admin_password = ::EtFullSystem::Test::Configuration.admin_password
  admin_pages.dashboard_page.admin_login(admin_username, admin_password)
  admin_pages.any_page.menu.click_users
  admin_pages.users_page.delete_user_from_admin("#{@user[:email]}@blah.com")
end

Then("import {string} users") do |string|
  @email = string
  @users = create(:users)
  admin_pages.any_page.menu.click_users
  admin_pages.users_page.click_import_users
  admin_pages.import_file_page.choose_file(@users)
end

Then("users have successfully been imported") do
  begin
    admin_pages.users_page.search_by_email('Starts with', @email)
    admin_pages.users_page.assert_users_are_imported
    admin_pages.any_page.menu.click_users
  ensure
    admin_api = EtFullSystem::Test::AdminApi.new atos_interface: atos_interface
    filename = File.expand_path(File.join('features', 'support', 'fixtures', 'et_admin_users.csv'))
    aggregate_failures 'Validating user has been deleted' do
      CSV.foreach(filename, :headers => true) do |csv_row|
        admin_api.delete_user_by_email(csv_row['email'])
      end
    end
  end
end
