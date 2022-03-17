FactoryBot.define do
  factory :claim, class: OpenStruct do
    claim_types do
      build :claim_type, :all
    end
    similar_claims {:"claims.claim_type.no"}
    other_additional_information {:'claims.additional_information.has_miscellaneous_information.options.no'}

    description {'Full text version of claim'}

    trait :simple do
      claim_types do
        build :claim_type, :unfair_dismissal
      end
      similar_claims {:"claims.claim_type.no"}
    end
  end

  trait :upload_your_claim_statement do
    preferred_outcome do
      [:"compensation_only",
      :"tribunal_recommendation",
      :"reinstated_employment_and_compensation",
      :"new_employment_and_compensation"]
    end
    preferred_outcome_notes {'I would like 50,000 GBP due to the stress this caused me'}
    whistleblowing_claim {:"claims.claim_type.yes"}
    send_to_relevant_person {:"simple_form.yes"}
    similar_claims {:"claims.claim_type.yes"}
    add_other_claimants {'Jimmy Barnes, Bryon Adams, Shelly Temple, Doris Day'}
    other_claimant_names {'Similar Claim1, Similar Claim2'}
    rtf_file {'simple_user_with_rtf.rtf'}
    other_additional_information {:'claims.additional_information.has_miscellaneous_information.options.yes'}
    other_important_details {'Here are some very important details that need to be considered'}
  end

  trait :no_to_other_claimants do
    preferred_outcome do
      [:compensation_only,
      :tribunal_recommendation,
      :reinstated_employment_and_compensation,
      :new_employment_and_compensation]
    end
    preferred_outcome_notes {'I would like 50,000 GBP due to the stress this caused me'}
    whistleblowing_claim {:"claims.claim_type.no"}
    similar_claims {:"claims.claim_type.yes"}
    other_claimant_names {'James Blunt, Punky Brewsters, Shirly Temple'}
    other_additional_information {:'claims.additional_information.has_miscellaneous_information.options.yes'}
    other_important_details {'Here are some very important details that need to be considered'}
  end

  trait :no_to_whistleblowing_claim do
    preferred_outcome do
      [:compensation_only,
      :tribunal_recommendation,
      :reinstated_employment_and_compensation,
      :new_employment_and_compensation]
    end
    preferred_outcome_notes {'I would like 50,000 GBP due to the stress this caused me'}
    whistleblowing_claim {:"claims.claim_type.no"}
    similar_claims {:"claims.claim_type.yes"}
    other_claimant_names {'Jimmy Barnes, Bryon Adams, Shelly Temple, Doris Day'}
    other_additional_information {:'claims.additional_information.has_miscellaneous_information.options.yes'}
    other_important_details {'Here are some very important details that need to be considered'}
  end

  trait :yes_to_whistleblowing_claim do
    preferred_outcome do
      [:compensation_only,
      :tribunal_recommendation,
      :reinstated_employment_and_compensation,
      :new_employment_and_compensation]
    end
    preferred_outcome_notes {'I would like 50,000 GBP due to the stress this caused me'}
    whistleblowing_claim {:"claims.claim_type.yes"}
    send_to_relevant_person {:"simple_form.yes"}
    similar_claims {:"claims.claim_type.yes"}
    other_claimant_names {'James Blunt, Punky Brewsters, Shirly Temple'}
    other_additional_information {:'claims.additional_information.has_miscellaneous_information.options.yes'}
    other_important_details {'Here are some very important details that need to be considered'}
  end

  trait :no_to_multiple_claims do
    preferred_outcome do
      [:compensation_only,
      :tribunal_recommendation,
      :reinstated_employment_and_compensation,
      :new_employment_and_compensation]
    end
    preferred_outcome_notes {'I would like 50,000 GBP due to the stress this caused me'}
    whistleblowing_claim {:"claims.claim_type.yes"}
    send_to_relevant_person {:"simple_form.yes"}
    similar_claims {:"claims.claim_type.no"}
    other_claimant_names {''}
    other_additional_information {:'claims.additional_information.has_miscellaneous_information.options.yes'}
    other_important_details {'Here are some very important details that need to be considered'}
  end

  trait :nil_to_claim_outcome do
    preferred_outcome {[]}
    preferred_outcome_notes {''}
    whistleblowing_claim {:"claims.claim_type.yes"}
    send_to_relevant_person {:"simple_form.yes"}
    similar_claims {:"claims.claim_type.no"}
    other_claimant_names {''}
    other_additional_information {:'claims.additional_information.has_miscellaneous_information.options.yes'}
    other_important_details {'Here are some very important details that need to be considered'}
  end

  trait :no_to_other_important_details do
    preferred_outcome do
      [:compensation_only,
      :tribunal_recommendation,
      :reinstated_employment_and_compensation,
      :new_employment_and_compensation]
    end
    preferred_outcome_notes {''}
    whistleblowing_claim {:"claims.claim_type.yes"}
    send_to_relevant_person {:"simple_form.yes"}
    similar_claims {:"claims.claim_type.no"}
    other_claimant_names {''}
    other_additional_information {:'claims.additional_information.has_miscellaneous_information.options.no'}
    other_important_details {''}
  end
end
