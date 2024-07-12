require 'faker'

FactoryBot.define do
  factory :employment, class: OpenStruct do
    trait :no_employment do
      employment_details {:"claims.employment.no"}
    end

    trait :notice_period do
      employment_details {:"claims.employment.yes"}
      current_situation {:"simple_form.options.employment.current_situation.notice_period"}
      job_title { Faker::Company.profession }
      start_date {'18/11/2009'}
      end_date {''}
      #Did you work (or get paid for) a period of notice?
      paid_for_notice_period {:"claims.employment.paid_for_notice_period.no"}
      notice_period {nil}
      notice_period_type {nil}
      notice_period_end_date {'01/01/2025'}
      average_weekly_hours {'38'}
      pay_period_type { :"simple_form.options.employment.pay_period_type.monthly" }
      pay_before_tax {'3000'}
      pay_after_tax {'2000'}
      employers_pension_scheme {:"simple_form.labels.employment.enrolled_in_pension_scheme.options.no"}
      benefits {'Company car, private health care'}
      #New Job
      new_job {nil}
      new_job_start_date {''}
      new_job_before_tax {''}
      new_job_pay_before_tax {''}
    end

    trait :still_employed do
      employment_details {:"claims.employment.yes"}
      current_situation {:"simple_form.options.employment.current_situation.still_employed"}
      job_title { Faker::Company.profession }
      start_date {'18/11/2009'}
      end_date {''}
      #Did you work (or get paid for) a period of notice?
      paid_for_notice_period {:"claims.employment.paid_for_notice_period.no"}
      notice_period {'3'}
      notice_period_type {nil}
      notice_period_end_date {''}
      average_weekly_hours {'38'}
      pay_period_type { :"simple_form.options.employment.pay_period_type.monthly" }
      pay_before_tax {'3000'}
      pay_after_tax {'2000'}
      employers_pension_scheme {:"simple_form.labels.employment.enrolled_in_pension_scheme.options.yes"}
      benefits {'Company car, private health care'}
      #New Job
      new_job {nil}
      new_job_start_date {''}
      new_job_before_tax {''}
      new_job_pay_before_tax {''}
    end

    trait :employment_terminated do
      employment_details {:"claims.employment.yes"}
      current_situation {:"simple_form.options.employment.current_situation.employment_terminated"}
      job_title { Faker::Company.profession }
      start_date {'18/11/2009'}
      end_date {'01/01/2019'}
      #Did you work (or get paid for) a period of notice?
      paid_for_notice_period {:"claims.employment.paid_for_notice_period.yes"}
      notice_period {'3'}
      notice_period_type {:"simple_form.options.employment.notice_pay_period_type.weeks"}
      notice_period_end_date {''}
      average_weekly_hours {'38'}
      # Pay, pension and benefits
      pay_period_type { :"simple_form.options.employment.pay_period_type.monthly" }
      pay_before_tax {'3000'}
      pay_after_tax {'2000'}
      employers_pension_scheme {:"simple_form.labels.employment.enrolled_in_pension_scheme.options.yes"}
      benefits {'Company car, private health care'}
      #New Job
      new_job {:"claims.employment.new_job.yes"}
      new_job_start_date {'18/11/2009'}
      new_job_pay_before_tax_type {:"simple_form.options.employment.new_job_gross_pay_frequency.monthly"}
      new_job_pay_before_tax {'3000'}
    end

    trait :no_employment_details do
      employment_details {:"claims.employment.no"}
      #New Job
      new_job {nil}
      new_job_start_date {''}
      new_job_before_tax {''}
      new_job_pay_before_tax {''}
    end
  end
end
