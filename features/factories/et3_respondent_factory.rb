require 'faker'

FactoryBot.define do
  factory :et3_respondent, class: OpenStruct do
    case_number {"2454321/2017"}
    title { 'Mr' }
    company_number { '63729391' }
    company_type { :limited_company }
    name { Faker::Company.name }
    building_name {"the-shard"}
    street_name { Faker::Address.street_name }
    town {"westminster"}
    county {"london"}
    postcode {"wc1 1aa"}
    organisation_more_than_one_site {:"questions.organisation_more_than_one_site.options.no"}
    allow_phone_or_video_attendance { [:video] }
    memorable_word { 'password' }
  end

  factory :et3_dummy_data, class: OpenStruct do
    case_number {"2454321/2017"}
    name { 'dumm data' }
    building_name {'dumm data'}
    street_name {'dumm data' }
    town {'dumm data'}
    county {'dumm data'}
    postcode {'M1 1AQ'}
    organisation_more_than_one_site {:"questions.organisation_more_than_one_site.options.no"}
  end

  trait :et3_respondent_answers do
    contact { Faker::Name.name }
    county {"london"}
    dx_number {"234242342"}
    contact_number {"02081234567"}
    contact_mobile_number {"07123456789"}
    contact_preference {:"questions.contact_preference.options.email"}
    email_address {"respondent@hmcts.net"}
    organisation_employ_gb {"100"}
    make_employer_contract_claim {:"questions.make_employer_contract_claim.options.yes"}
    claim_information {"lorem ipsum info"}
    email_receipt {"respondent@hmcts.net"}
    disability {:"questions.disability.options.yes"}
    disability_information {"Lorem ipsum disability"}
  end

  trait :upload_additional_information do
    rtf_file {'simple_user_with_rtf.rtf'}
  end

  trait :et3_respondent_optionals do
    contact {''}
    county {''}
    dx_number {''}
    contact_number {''}
    contact_mobile_number {''}
    contact_preference {nil}
    email_address {''}
    organisation_employ_gb {''}
    make_employer_contract_claim {nil}
    claim_information {''}
    email_receipt {''}
    disability {nil}
    disability_information {''}
    allow_phone_or_video_attendance { [] }
  end
end
