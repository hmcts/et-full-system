FactoryBot.define do
  factory :claim_type, class: OpenStruct do
    unfair_dismissal { [] }
    discrimination { [] }
    pay { [] }
    other { [] }
    other_type_of_claim_details { nil }
    whistleblowing_claim {:yes}
    send_to_relevant_person {:"simple_form.labels.claim_type.send_claim_to_whistleblowing_entity.options.yes"}
    trait :unfair_dismissal do
      unfair_dismissal do
        [:is_unfair_dismissal]
      end
    end
    trait :all do
      unfair_dismissal
      discrimination do
        [
          :sex_including_equal_pay,
          :race,
          :pregnancy_or_maternity,
          :sexual_orientation,
          :gender_reassignment,
          :disability,
          :age,
          :religion_or_belief,
          :marriage_or_civil_partnership
        ]
      end
  
      pay do
        [
          :redundancy,
          :holiday,
          :other,
          :notice,
          :arrears
        ]
      end
  
      other do
        [:is_other_type_of_claim]
      end
      other_type_of_claim_details {'Give a very short description of your claim; you will have the opportunity to add more detail on the next page'}
  
    end
  end
end
