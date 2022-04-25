require 'rspec/matchers'
module EtFullSystem
  module Test
    class CcdApi
      include ::RSpec::Matchers

      def initialize
        self.cookies_hash = HTTParty::CookieHash.new
      end

      def ccd_url
        Configuration.ccd_client_url
      end

      def oauth2redirect
        Configuration.oauth2redirect
      end

      def case_url
        Configuration.ccd_case_url
      end

      def get_cookies
        response = request(:get, "#{ccd_url}/login?response_type=code&client_id=ccd_gateway&redirect_uri=#{oauth2redirect}")
        self.csrf_token = response.body.match(/_csrf" value="([^"]*)"/)[1]
      end

      def get_oauth2redirect_code
        response = request(:post, "#{ccd_url}/login?response_type=code&client_id=ccd_gateway&redirect_uri=#{oauth2redirect}",
          follow_redirects: false,
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded'
          },
          cookies: cookies_hash,
          body: {
            username: Configuration.ccd_username,
            password: Configuration.ccd_password,
            continue: oauth2redirect,
            upliftToken: '',
            response_type: 'code',
            _csrf: csrf_token,
            redirect_uri: oauth2redirect,
            client_id: 'ccd_gateway',
            scope: '',
            state: ''
          })
          self.oauth2redirect_code = response.headers['location'].split("=").pop()
      end

      def get_access_token
        response = request(:get, "#{case_url}/oauth2?code=#{oauth2redirect_code}&redirect_uri=#{oauth2redirect}",
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded'
          }
        )
        self.access_token = cookies_hash[:accessToken]
      end

      def get_ccd_case(fee_group_reference)
        response = request(:get, "#{case_url}/aggregated/caseworkers/:uid/jurisdictions/EMPLOYMENT/case-types/Manchester_Dev/cases?view=WORKBASKET&state=1_Submitted&page=1&case.feeGroupReference=#{fee_group_reference}&page=1&sortDirection=desc",
          headers: {
            'Content-Type' => 'application/json'
          },
          cookies: {
            accessToken: access_token
          }
        )
        self.case_response = response['results'].first['case_fields']
      end

      def caseworker_search_latest_by_reference(reference_number)
        get_cookies
        get_oauth2redirect_code
        get_access_token
        get_ccd_case(reference_number)
      end

      private

      def request(method, url, options = {})
        self.last_response = HTTParty.send(method, url, options.merge(verify: false))
        if last_response.headers.key? "set-cookie"
          cookies_hash.add_cookies(last_response.headers['set-cookie'])
        end
        last_response
      end

      attr_accessor :cookies_hash, :last_response, :csrf_token, :oauth2redirect_code, :access_token, :case_response
    end
  end
end
