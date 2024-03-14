require 'faker'

FactoryBot.define do
  factory :claimant, class: OpenStruct do
    gender { :"simple_form.options.claimant.gender.prefer_not_to_say" }
    country { :"simple_form.options.claimant.address_country.united_kingdom" }
    has_special_needs { :"simple_form.yes" }
    special_needs { 'My special needs are as follows' }
    telephone_number { '01234 567890' }
    alternative_telephone_number { '01234 098765' }
    email_address { "claimant@hmcts.net" }
    correspondence { :"simple_form.options.claimant.contact_preference.email" }
    memorable_word { 'password' }
    allow_video_attendance { :"simple_form.options.claimant.allow_video_attendance.yes" }

    trait :contact_by_post do
      correspondence { :"simple_form.options.claimant.contact_preference.post" }
    end

    trait :contact_by_email do
      correspondence { :"simple_form.options.claimant.contact_preference.email" }
    end
    trait :person_data do
      title { :"simple_form.options.claimant.title.ms" }
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      date_of_birth { '21/11/1982' }
      building { Faker::Address.building_number }
      street { Faker::Address.street_name }
      locality { 'London' }
      county { 'Manchester' }
      post_code { 'SW1H 9AJ' }
    end

    trait :person_data_no_dob do
      title { :"simple_form.options.claimant.title.ms" }
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      date_of_birth { nil }
      building { Faker::Address.building_number }
      street { Faker::Address.street_name }
      locality { 'London' }
      county { 'Manchester' }
      post_code { 'SW1H 9AJ' }
    end

    trait :fake_ccd_error_422_claimant do
      title { :"simple_form.options.claimant.title.ms" }
      first_name { 'Force' }
      last_name { "ErrorUnprocessableEntity #{SecureRandom.uuid.gsub(/[\d-]/) { |x| (x.ord + 58).chr }}" }
      date_of_birth { '21/11/1982' }
      building { Faker::Address.building_number }
      street { Faker::Address.street_name }
      locality { 'London' }
      county { 'Manchester' }
      post_code { 'SW1H 9AJ' }
    end

    trait :fake_ccd_error_502_once_claimant do
      title { :"simple_form.options.claimant.title.ms" }
      first_name { 'Force' }
      last_name { "ErrorBadGateway-#{SecureRandom.uuid.gsub(/[\d-]/) { |x| (x.ord + 58).chr }}" }
      date_of_birth { '21/11/1982' }
      building { Faker::Address.building_number }
      street { Faker::Address.street_name }
      locality { 'London' }
      county { 'Manchester' }
      post_code { 'SW1H 9AJ' }
    end

    trait :dummy_data do
      title { :"simple_form.options.claimant.title.ms" }
      first_name { 'DUMMY' }
      last_name { 'DATA' }
      date_of_birth { '21/11/1982' }
      building { 'DUMMY DATA' }
      street { 'DUMMY DATA' }
      locality { 'London' }
      county { 'Manchester' }
      post_code { 'M1 1AQ' }
    end

    trait :person_with_no_gender_information do
      person_data
      gender { nil }
      title { nil }
    end

    trait :group_claims do
      group_claims_csv { 'simple_user_with_csv_group_claims.csv' }
    end
  end
end
