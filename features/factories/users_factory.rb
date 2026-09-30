require 'faker'

FactoryBot.define do
  factory :users, class: OpenStruct do
    name { Faker::Name.name }
    email { Faker::Name.first_name }
    username { "sivo#{Time.now.strftime('%j%H%M%S%3N')}" }
    department { 'DCD' }
    password { 'password' }
    users_file { 'et_admin_users.csv' }
  end
end
