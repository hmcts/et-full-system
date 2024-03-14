require 'mail'
require_relative './base'
require 'rack/utils'
module EtFullSystem
  module Test
    class Et1ResetPasswordEmailHtml < Base
      include RSpec::Matchers

      # @return [Et1::Test::EmailObjects::ResetPasswordEmailHtml, Nil]
      def self.find(search_url: ::EtFullSystem::Test::Configuration.mailhog_search_url, email_address:, sleep: 10, timeout: 50)
        item = find_email(email_address, search_url, sleep: sleep, timeout: timeout)
        raise "ET1 Reset password html email for  #{email_address} not found" unless item.present?
        new(item)
      end

      def self.find_email(email_address, search_url, timeout: 50, sleep: 10, subject_text: 'Employment Tribunal: Reset your memorable word')
        Timeout.timeout(timeout) do
          item = nil
          until item.present? do
            query = Rack::Utils.build_query(kind: 'containing', query: email_address, start: 0, limit: 10)
            url = URI.parse(search_url)
            url.query = query
            response = HTTParty.get(url, headers: { accept: 'application/json' })
            item = response.parsed_response['items'].detect {|i| i.dig('Content', 'Headers', 'Subject').try(:first) == subject_text}
            sleep sleep unless item.present?
          end
          Mail.new item.dig('Raw', 'Data')
        end
      rescue Timeout::Error
        return nil
      end

      def has_correct_email_address?
        mail.from.include? "fredbloggs@example.com"
      end

      def has_correct_content_for?(comments:, suggestions:, email_address:) # rubocop:disable Naming/PredicateName
        aggregate_failures 'validating content' do
          expect(has_correct_subject?).to be true
          expect(has_correct_email_address?).to be true
        end
        true
      end

      def has_correct_subject? # rubocop:disable Naming/PredicateName
        mail.subject == "Employment Tribunal: Reset your memorable word"
      end

      def has_correct_to_address?(email_address) # rubocop:disable Naming/PredicateName
        mail.to.include?(email_address)
      end

      def reset_memorable_word_url
        reset_memorable_word_link[:href]
      end

      private

      element :reset_memorable_word_link, :link, 'Reset my memorable word'

      attr_accessor :mail
    end
  end
end
