require 'faker'

FactoryBot.define do
  factory :et3_claimant, class: OpenStruct do
  end

  trait :disagree_with_employment_dates do
    claimants_name { Faker::Name.name }
    agree_with_early_conciliation_details {:"questions.agree_with_early_conciliation_details.options.no"}
    disagree_conciliation_reason {"lorem ipsum conciliation"}
    continued_employment {:"questions.continued_employment.options.no"}
    agree_with_claimants_description_of_job_or_title {:"questions.agree_with_claimants_description_of_job_or_title.options.no"}
    disagree_claimants_job_or_title {"lorem ipsum job title"}
    agree_with_claimants_hours {:"questions.agree_with_claimants_hours..options.no"}
    queried_hours {32.0}
    agree_with_earnings_details {:"questions.agree_with_earnings_details.options.no"}
    queried_pay_before_tax {1000.0}
    queried_pay_before_tax_period {"Monthly"}
    queried_take_home_pay {900.0}
    queried_take_home_pay_period {"Monthly"}
    agree_with_claimant_notice {:"questions.agree_with_claimant_notice.options.no"}
    disagree_claimant_notice_reason {"lorem ipsum notice reason"}
    agree_with_claimant_pension_benefits {:"questions.agree_with_claimant_pension_benefits.options.no"}
    disagree_claimant_pension_benefits_reason {"lorem ipsum claimant pension"}
    defend_claim {:"questions.defend_claim.options.yes"}
    defend_claim_facts {"lorem ipsum defence"}
    agree_with_employment_dates {:"questions.agree_with_employment_dates.options.no"}
    employment_start {"01/01/2017"}
    employment_end {"31/12/2017"}
    disagree_employment {"lorem ipsum employment"}
  end

  trait :disagree_with_employment_dates_invalid_date do
    claimants_name { Faker::Name.name }
    agree_with_early_conciliation_details {:"questions.agree_with_early_conciliation_details.options.no"}
    disagree_conciliation_reason {"lorem ipsum conciliation"}
    continued_employment {:"questions.continued_employment.options.no"}
    agree_with_claimants_description_of_job_or_title {:"questions.agree_with_claimants_description_of_job_or_title.options.no"}
    disagree_claimants_job_or_title {"lorem ipsum job title"}
    agree_with_claimants_hours {:"questions.agree_with_claimants_hours..options.no"}
    queried_hours {32.0}
    agree_with_earnings_details {:"questions.agree_with_earnings_details.options.no"}
    queried_pay_before_tax {1000.0}
    queried_pay_before_tax_period {"Monthly"}
    queried_take_home_pay {900.0}
    queried_take_home_pay_period {"Monthly"}
    agree_with_claimant_notice {:"questions.agree_with_claimant_notice.options.no"}
    disagree_claimant_notice_reason {"lorem ipsum notice reason"}
    agree_with_claimant_pension_benefits {:"questions.agree_with_claimant_pension_benefits.options.no"}
    disagree_claimant_pension_benefits_reason {"lorem ipsum claimant pension"}
    defend_claim {:"questions.defend_claim.options.yes"}
    defend_claim_facts {"lorem ipsum defence"}
    agree_with_employment_dates {:"questions.agree_with_employment_dates.options.no"}
    employment_start {"0/0/0"}
    employment_end {"0/0/0"}
    disagree_employment {"lorem ipsum employment"}
  end

  trait :agree_with_employment_dates do
    claimants_name { Faker::Name.name }
    agree_with_early_conciliation_details {:"questions.agree_with_early_conciliation_details.options.no"}
    disagree_conciliation_reason {'lorem ipsum conciliation'}
    continued_employment {:"questions.continued_employment.options.no"}
    agree_with_claimants_description_of_job_or_title {:"questions.agree_with_claimants_description_of_job_or_title.options.no"}
    disagree_claimants_job_or_title {'lorem ipsum job title'}
    agree_with_claimants_hours {:"questions.agree_with_claimants_hours.options.no"}
    queried_hours {32.0}
    agree_with_earnings_details {:"questions.agree_with_earnings_details.options.no"}
    queried_pay_before_tax {1000.0}
    queried_pay_before_tax_period {"Monthly"}
    queried_take_home_pay {900.0}
    queried_take_home_pay_period {"Monthly"}
    agree_with_claimant_notice {:"questions.agree_with_claimant_notice.options.no"}
    disagree_claimant_notice_reason {'lorem ipsum notice reason'}
    agree_with_claimant_pension_benefits {:"questions.agree_with_claimant_pension_benefits.options.no"}
    disagree_claimant_pension_benefits_reason {'lorem ipsum claimant pension'}
    defend_claim {:"questions.defend_claim.options.yes"}
    defend_claim_facts {'lorem ipsum defence'}
    agree_with_employment_dates {:"questions.agree_with_employment_dates.options.yes"}
    employment_start {''}
    employment_end {''}
    disagree_employment {''}
  end

  trait :et3_claimant_optionals do
    claimants_name {''}
    agree_with_early_conciliation_details {:"questions.agree_with_early_conciliation_details.options.no"}
    disagree_conciliation_reason {''}
    continued_employment { nil }
    agree_with_claimants_description_of_job_or_title {nil}
    disagree_claimants_job_or_title {''}
    agree_with_claimants_hours {nil}
    queried_hours {''}
    agree_with_earnings_details {nil}
    queried_pay_before_tax {''}
    queried_pay_before_tax_period {nil}
    queried_take_home_pay {''}
    queried_take_home_pay_period {nil}
    agree_with_claimant_notice {nil}
    disagree_claimant_notice_reason {''}
    agree_with_claimant_pension_benefits {nil}
    disagree_claimant_pension_benefits_reason {''}
    defend_claim {:"questions.defend_claim.options.no"}
    defend_claim_facts {''}
    agree_with_employment_dates {:"questions.agree_with_employment_dates.options.yes"}
    allow_phone_or_video_attendance { [] }
    employment_start {''}
    employment_end {''}
    disagree_employment {''}
  end
end
