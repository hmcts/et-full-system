require 'faker'

FactoryBot.define do
  factory :respondent, class: OpenStruct do
    name { Faker::Company.name }
    trait :work_address do
        work_building {'20'}
        work_street {'York St'}
        work_locality {'Glasgow'}
        work_county {'Lanarkshire'}
        work_post_code {'G2 8GT'}
        work_telephone_number {'0141 302 5858'}
        expected_office { '41' }
    end

    trait :yes_acas do
      acas_number {'R000100/18/68'}
    end

    trait :main_address do
      building { Faker::Address.building_number }
      street { Faker::Address.street_name }
      locality {'London'}
      county {'Greater London'}
      post_code {'SW1H 9QR'}
      telephone_number {'02222 321654'}
      expected_office { '22' }
    end

    trait :both_addresses do
      main_address
      work_address
    end

    trait :no_acas do
      no_acas_number_reason {:"simple_form.options.respondent.no_acas_number_reason.joint_claimant_has_acas_number"}
    end

    trait :secondary do
      telephone_number {nil}
    end

    factory :et3_data, traits: [:work_address, :yes_acas]
  end
end
