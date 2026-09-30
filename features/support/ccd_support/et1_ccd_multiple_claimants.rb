require 'et_ccd_client'
require 'csv'
require_relative './base'
require_relative './et1_claimant_type'
require_relative './ccd_file_helper'

module EtFullSystem
  module Test
    module Ccd
      class Et1CcdMultipleClaimants < Base
        include ::EtFullSystem::Test::I18n
        include RSpec::Matchers
        include ::EtFullSystem::Test::Et1ClaimantType
        include ::EtFullSystem::Test::CcdFileHelper

        def initialize(response)
          self.response = response
        end

        def self.find_multiples_by_reference(reference_number, ccd_office, timeout: 60, sleep: 0.5)
          Timeout.timeout(timeout) do
            response = nil
            until response.present?
              response = ccd.caseworker_search_latest_by_multiple_reference(reference_number, case_type_id: ccd_office)
              yield if block_given?
              sleep sleep unless response.present?
            end
            new(response)
          end
        rescue Timeout::Error
          nil
        end

        def assert_multiple_title(title)
          expect(response['case_fields']).to include 'multipleName' => title
        end

        def assert_primary_claimant(claimant, representative, employment, respondents, reference_number, ccd_office,
                                    claim)
          aggregate_failures 'validating key fields' do
            created_case = primary_case(ccd_office)

            expect(created_case['case_fields']).to include 'leadClaimant' => 'Yes'
            expect(created_case['case_fields']).to include case_details(reference_number)
            expect(created_case['case_fields']).to include 'claimantIndType' => a_hash_including(claimant_ind_type(claimant[0]).as_json)
            expect(created_case['case_fields']).to include 'claimantType' => a_hash_including(claimant_type(claimant[0]).as_json)
            expect(created_case['case_fields']).to include 'claimantType' => a_hash_including(claimant_type_address(claimant[0]).as_json)

            if representative[0]['representative_have'] == 'No'
              expect(created_case['case_fields']).to include 'claimantRepresentedQuestion' => 'No'
            else
              expect(created_case['case_fields']).to include 'representativeClaimantType' => a_hash_including(representative_address(representative[0]).as_json)
              expect(created_case['case_fields']).to include 'representativeClaimantType' => a_hash_including(representative_claimant_type(representative[0]).as_json)
            end

            if employment[:employment_details] == :"claims.employment.no"
              expect(created_case['case_fields']).to include 'claimantOtherType' => a_hash_including(
                'claimant_disabled' => t(claimants[0][:has_special_needs]), 'claimant_disabled_details' => claimants[0][:special_needs]
              )
            else
              expect(created_case['case_fields']).to include 'claimantOtherType' => a_hash_including(claimant_other_type(
                employment, claimant
              ).as_json)
            end

            expect(created_case['case_fields']).to include 'claimantWorkAddress' => a_hash_including(claimant_work_address(respondents[0]).as_json)

            respondents.each_with_index do |respondent, i|
              expect(created_case['case_fields']['respondentCollection'][i]).to include 'value' => a_hash_including(respondent_sum_type(respondent))
            end

            filenames = created_case.dig('case_fields', 'documentCollection').map do |doc|
              doc.dig('value', 'uploadedDocument', 'document_filename')
            end
            expected_filenames = %W[
              et1_#{claimant.first.first_name.underscore}_#{claimant.first.last_name.downcase.delete("'")}.pdf acas_#{respondents.first.name}.pdf
            ]
            # The first respondent's acas is guaranteed to be in CCD but the other 4 (max) may come
            # later - and are not really important - so we ignore them if they are present
            respondents[1..4].each do |respondent|
              filenames.delete("acas_#{respondent.name}.pdf")
            end
            if claimant.first.group_claims_csv.present?
              expected_filenames << "et1a_#{claimant.first.first_name}_#{claimant.first.last_name}.csv"
            end
            if claim.rtf_file.present?
              expected_filenames << "et1_attachment_#{claimant.first.first_name}_#{claimant.first.last_name}.rtf"
            end

            expect(filenames).to match_array(expected_filenames)
          end
        end

        def find_pdf_file(ccd_office)
          download_file(primary_case(ccd_office), 'pdf')
        end

        def find_rtf_file(ccd_office)
          download_file(primary_case(ccd_office), 'pdf')
        end

        def find_csv_file(ccd_office)
          download_file(primary_case(ccd_office), 'csv')
        end

        def multiple_claimants_xls(claimants)
          return unless claimants[0].dig(:group_claims_csv)

          filename = File.expand_path(File.join('features', 'support', 'fixtures',
                                                'simple_user_with_csv_group_claims.csv'))
          data = []
          CSV.foreach(filename, headers: true) do |csv_row|
            data << csv_row
          end
          data
        end

        def all_filenames(ccd_office)
          documents(primary_case(ccd_office))
        end

        def assert_valid_filenames(ccd_office:, et1_multiple_claimants: true, et1_additional_info: true); end

        def assert_secondary_xls_claimants(claimants, representative, _employment, respondents, ccd_office)
          secondary_claimants_left = multiple_claimants_xls(claimants)
          secondary_cases = cases(ccd_office).reject { |ccd_case| ccd_case['leadClaimant'] == 'Yes' }

          secondary_cases.each do |secondary_case|
            expect(secondary_case).to include 'leadClaimant' => 'No'

            claimant = secondary_claimants_left.find do |c|
              # claimant
              secondary_case['claimantIndType']
              claimant_csv_ind_type(c)
              secondary_case['claimantType'] == secondary_xls_claimant_type_address(c)
            end
            raise "validating claimant details: #{secondary_claimants_left}" if claimant.nil?

            secondary_claimants_left.delete(claimant)
            # representative
            secondary_case['representativeClaimantType'] == secondary_representative(representative[0])
            # employment
            secondary_case['claimantOtherType'] == {}
            # respondents
            respondents.drop(1).each_with_index do |respondent, i|
              expect(secondary_case['respondentCollection'][i]).to include 'value' => a_hash_including(respondent_sum_type(respondent))
            end
          end
          expect(secondary_claimants_left).to be_empty
        end

        def assert_secondary_claimant(claimants, representative, _employment, respondents, ccd_office)
          secondary_claimants_left = claimants.drop(1)
          secondary_cases = cases(ccd_office).reject { |ccd_case| ccd_case['leadClaimant'] == 'Yes' }

          secondary_cases.each do |secondary_case|
            expect(secondary_case).to include 'leadClaimant' => 'No'

            claimant = secondary_claimants_left.find do |c|
              # claimant
              secondary_case['claimantIndType']
              claimant_ind_type(c, secondary: true)
              secondary_case['claimantType'] == secondary_claimant_type_address(c, secondary: true)
            end
            raise "validating claimant details: #{secondary_claimants_left}" if claimant.nil?

            secondary_claimants_left.delete(claimant)
            # representative
            secondary_case['representativeClaimantType'] == secondary_representative(representative[0])
            # employment
            secondary_case['claimantOtherType'] == {}
            # respondents
            respondents.each_with_index do |respondent, i|
              expect(secondary_case['respondentCollection'][i]&.fetch('value',
                                                                      {})).to include respondent_sum_type(respondent)
            end
          end
          expect(secondary_claimants_left).to be_empty
        end

        private

        attr_accessor :response

        def case_references
          response.dig('case_fields', 'caseIdCollection').map do |item|
            item.dig('value', 'ethos_CaseReference')
          end
        end

        def cases(ccd_office)
          case_references.filter_map do |reference|
            ccd_case = ccd.caseworker_search_latest_by_ethos_case_reference(reference, case_type_id: ccd_office)
            ccd_case&.fetch('case_fields', nil)
          end
        end

        def primary_case(ccd_office, timeout: 30, sleep: 0.5)
          Timeout.timeout(timeout) do
            loop do
              primary = cases(ccd_office).find { |ccd_case| ccd_case['leadClaimant'] == 'Yes' }
              return { 'case_fields' => primary } if primary.present?

              sleep sleep
            end
          end
        rescue Timeout::Error
          raise "Lead claimant was not found in CCD case collection containing references #{case_references.join(', ')}"
        end

        def case_details(reference_number)
          {
            'receiptDate' => Time.now.strftime('%Y-%m-%d'),
            'feeGroupReference' => reference_number,
            'claimant_TypeOfClaimant' => 'Individual',
            'positionType' => 'Received by Auto-Import'
          }
        end
      end
    end
  end
end
