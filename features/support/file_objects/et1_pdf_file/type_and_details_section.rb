require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class TypeAndDetailsSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          # Note that at present, the test framework suggests only one claim type but ET1 can have many selected - this code will need to expect
          # various fields to be Yes/No based on a list of claim types in the future.
          # Also, alot of values have hard coded true or falses as I expect these to come from factories but at the time of writing this there are
          # no values for them - so Im not going mad - calling a method that returns "yes" or "no" - knowing it will always return "no" as I am passing it false
          # it simply to allow for the value to be added at some point soon.
          def has_contents_for?(claim:)
            claim_types = claim.claim_types
            expected_values = {
              discriminated: (claim_types.unfair_dismissal + claim_types.discrimination + claim_types.pay + claim_types.other).present?,
              unfairly_dismissed: claim_types.unfair_dismissal.include?(:is_unfair_dismissal),
              discriminated_age: claim_types.discrimination.include?(:age),
              discriminated_race: claim_types.discrimination.include?(:race),
              discriminated_gender_reassignment: claim_types.discrimination.include?(:gender_reassignment),
              discriminated_disability: claim_types.discrimination.include?(:disability),
              discriminated_pregnancy: claim_types.discrimination.include?(:pregnancy_or_maternity),
              discriminated_marriage: claim_types.discrimination.include?(:marriage_or_civil_partnership),
              discriminated_sexual_orientation: claim_types.discrimination.include?(:sexual_orientation),
              discriminated_sex: claim_types.discrimination.include?(:sex_including_equal_pay),
              discriminated_religion: claim_types.discrimination.include?(:religion_or_belief),
              claiming_redundancy_payment: claim_types.pay.include?(:redundancy),
              owed_notice_pay: claim_types.pay.include?(:notice),
              owed_holiday_pay: claim_types.pay.include?(:holiday),
              owed_arrears_of_pay: claim_types.pay.include?(:arrears),
              owed_other_payments: claim_types.pay.include?(:other),
              other_type_of_claim: claim_types.other.include?(:is_other_type_of_claim),
              other_type_of_claim_details: claim_types.other_type_of_claim_details,
              claim_description: claim.description
            }
            expect(mapped_field_values).to include expected_values
          end
        end
      end
    end
  end
end
