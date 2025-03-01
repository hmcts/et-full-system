FactoryBot.define do
  factory :diversity, class: OpenStruct do
    trait :not_blank do
      claim_type { :"diversities.claim_type.claim_type.options.discrimination" }
      sex { :"diversities.identity.sex.options.female" }
      sexual_identity { :"diversities.identity.sexual_identity.options.heterosexual-straight" }
      age_group { :"age_group.under-25" }
      ethnicity { :"diversities.ethnicity.ethnicity_group.options.mixed-multiple-ethnic-groups" }
      ethnicity_subgroup do
        :"diversities.ethnicity.ethnicity_subgroup.mixed-multiple-ethnic-groups.options.white-and-black-caribbean"
      end
      disability { :"disability.prefer-not-to-say" }
      pregnancy { :"pregnancy.yes_answer" }
      caring_responsibility { :"caring_responsibility.yes_answer" }
      relationship { :"relationship.married" }
      religion { :"religion.no-religion" }
    end

    trait :blank do
      claim_type { nil }
      sex { nil }
      sexual_identity { nil }
      age_group { nil }
      ethnicity { nil }
      ethnicity_subgroup { nil }
      disability { nil }
      caring_responsibility { nil }
      gender { nil }
      gender_at_birth { nil }
      pregnancy { nil }
      relationship { nil }
      religion { nil }
    end
  end
end
