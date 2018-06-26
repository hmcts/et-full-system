require 'faker'

FactoryBot.define do
  factory :et3_respondent, class: OpenStruct do
      case_number '1454321/2017'
      name { Faker::Company.name }
      building_name 'the-shard'
      street_name { Faker::Address.street_name }
      town 'westminster'
      county 'london'
      postcode 'wc1 1aa'
      organisation_more_than_one_site 'No'
  end

  trait :et3_respondent_answers do
    contact { Faker::Name.name }
    county 'london'
    dx_number '724060 Derby 21'
    contact_number '02081234567'
    contact_mobile_number '07123456789'
    contact_preference 'email'
    email_address 'john@dodgyco.com'
    organisation_employ_gb '100'
    make_employer_contract_claim 'Yes'
    claim_information 'lorem ipsum info'
    email_receipt 'email@recei.pt'
  end

  trait :et3_respondent_optionals do
    contact ''
    county ''
    dx_number ''
    contact_number ''
    contact_mobile_number ''
    contact_preference ''
    email_address ''
    organisation_employ_gb ''
    make_employer_contract_claim ''
    claim_information ''
    email_receipt ''
  end
end