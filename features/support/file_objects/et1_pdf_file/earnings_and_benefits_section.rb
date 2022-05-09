require_relative './base.rb'
module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class EarningsAndBenefitsSection < EtFullSystem::Test::FileObjects::Et1PdfFileSection::Base
          def has_contents_for?(employment:)
            if employment.employment_details == :"claims.employment.yes" && employment.paid_for_notice_period == :"claims.employment.paid_for_notice_period.yes"
              expected_values = {
                average_weekly_hours: employment.try(:average_weekly_hours).try(:to_f).try(:to_s),
                pay_before_tax: pay_tax(employment.try(:pay_before_tax), employment.pay_period_type.to_s.split('.').last),
                pay_after_tax: pay_tax(employment.try(:pay_after_tax), employment.pay_period_type.to_s.split('.').last),
                paid_for_notice_period: employment.paid_for_notice_period.to_s.split('.').last == "yes",
                notice_period: notice_period(employment.notice_period, employment.notice_period_type),
                employers_pension_scheme: employers_pension_scheme(employment),
                benefits: employment.try(:benefits)
              }
            elsif employment.employment_details == :"claims.employment.yes" && employment.paid_for_notice_period == :"claims.employment.paid_for_notice_period.no"
              expected_values = {
                average_weekly_hours: employment.try(:average_weekly_hours).try(:to_f).try(:to_s),
                pay_before_tax: pay_tax(employment.try(:pay_before_tax), employment.pay_period_type.to_s.split('.').last),
                pay_after_tax: pay_tax(employment.try(:pay_after_tax), employment.pay_period_type.to_s.split('.').last),
                paid_for_notice_period: nil,
                notice_period: notice_period(employment.notice_period, employment.notice_period_type),
                employers_pension_scheme: employers_pension_scheme(employment),
                benefits: employment.try(:benefits)
              }
            else
              expected_values = {
                average_weekly_hours: be_blank,
                pay_before_tax: {
                    'amount': be_blank,
                    'period': be_blank
                },
                paid_for_notice_period: be_blank,
                notice_period: {
                    weeks: be_blank,
                    months: be_blank
                },
                employers_pension_scheme: be_blank,
                benefits: be_blank
              }
            end
            expect(mapped_field_values).to include expected_values
          end

          private

          def boolean_or_nil(value, true_value)
            return nil if value.nil?

            value == true_value
          end

          def employers_pension_scheme(employment)
            return nil if employment.nil?
            employment.employers_pension_scheme.to_s.split('.').last.downcase == 'true'
          end

          def notice_period(notice_period, notice_period_type)
            key = notice_period_type.to_s.split('.').last
            if key == "months"
              {:weeks=>"", :months=>"#{notice_period}.0"}
            elsif key == "weeks"
              {:weeks=>"#{notice_period}.0", :months=>""}
            else
              {:weeks=>"", :months=>""}
            end
          end

          def pay_tax(amount, period)
              {:amount=>"#{amount}", :period=>"#{period}"}
          end
        end
      end
    end
  end
end
