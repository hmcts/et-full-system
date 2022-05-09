FactoryBot.define do
  factory :representative, class: OpenStruct do
  end

  trait :et3_information do
    type {:"questions.type_of_representative.options.solicitor"}
    organisation_name { Faker::Company.bs }
    name { Faker::Name.name }
    building {'106'}
    street {'Mayfair'}
    locality {'London'}
    county {'Greater London'}
    post_code {'SW1H 9PP'}
    telephone_number {'01111 123456'}
    alternative_telephone_number {'02222 654321'}
    email_address  {'sivvoy.taing@hmcts.net'}
    dx_number  {'dx1234567890'}
    representative_have {:"questions.have_representative.options.yes"}
    representative_mobile {'07987654321'}
    representative_reference {'Rep Ref'}
    representative_contact_preference {:"questions.representative_contact_preference.options.fax"}
    representative_fax {'0207 345 6789'}
  end

  trait :et1_information do
    type {:"simple_form.options.representative.type.solicitor"}
    organisation_name { Faker::Company.bs }
    name { Faker::Name.name }
    building {'106'}
    street {'Mayfair'}
    locality {'London'}
    county {'Greater London'}
    post_code {'SW1H 9PP'}
    telephone_number {'01111 123456'}
    alternative_telephone_number {'02222 654321'}
    email_address  {'sivvoy.taing@hmcts.net'}
    dx_number  { nil }
    representative_have {'Yes'}
    representative_mobile {'07987654321'}
    representative_reference {'Rep Ref'}
    representative_fax {'0207 345 6789'}
    representative_contact_preference {:"simple_form.options.representative.contact_preference.email"}
  end

  trait :et1_no_representative do
    type {''}
    organisation_name {''}
    name {''}
    building {''}
    street {''}
    locality {''}
    county {''}
    post_code {''}
    telephone_number {''}
    alternative_telephone_number {''}
    email_address  {''}
    dx_number  {''}
    representative_have {'No'}
    representative_mobile {''}
    representative_reference {''}
    representative_fax {''}
    representative_contact_preference {''}
  end

  trait :et3_no_representative do
    type {''}
    organisation_name {''}
    name {''}
    building {''}
    street {''}
    locality {''}
    county {''}
    post_code {''}
    telephone_number {''}
    alternative_telephone_number {''}
    email_address  {''}
    dx_number  {''}
    have_representative {:"questions.have_representative.options.no"}
    representative_mobile {''}
    representative_reference {''}
    representative_contact_preference {nil}
    representative_fax {''}
    employer_contract_claim {''}
  end

  trait :contact_by_post do
    contact_preference { :"simple_form.options.representative.contact_preference.post" }
  end

  trait :contact_by_email do
    contact_preference { :"simple_form.options.representative.contact_preference.email" }
  end

end
