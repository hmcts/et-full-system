require 'rspec/matchers'
require 'mechanize'
module EtFullSystem
  module Test
    class AdminApi
      include ::RSpec::Matchers
      include ::EtFullSystem::Test::I18n


      def url
        Configuration.admin_url
      end

      def get_token
        response = request(:get, url)
        self.csrf_token = response.body.match(/csrf-token" content="([^"]*)"/)[1]
      end

      def mechanize_login
        return if mechanize_logged_in?
        page = agent.get(url)
        page.form.field_with(name: 'admin_user[username]').value = ::EtFullSystem::Test::Configuration.admin_username
        page.form.field_with(name: 'admin_user[password]').value = ::EtFullSystem::Test::Configuration.admin_password
        result = agent.submit(page.form)
        raise "Login failed" if result.search(XPath.generate {|x| x.descendant[x.string.n.contains("Signed in successfully")]}.to_s).empty?

        self.csrf_token = page.search('meta[name=csrf-token]').first['content']
        self.mechanize_logged_in = true
      end

      def login
        return if logged_in?
        get_token
        resp = request(:post, "#{url}/login",
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded'
          },
          cookies: cookies_hash,
          body: {
            admin_user: {
              username: ::EtFullSystem::Test::Configuration.admin_username,
              password: ::EtFullSystem::Test::Configuration.admin_password,
              remember_me: '0'
            },
            authenticity_token: csrf_token
          })
        raise "An error occured trying to login" unless resp.success?

        self.logged_in = true
      end

      def claims(query={})
        login
        claims = request(:get, "#{url}/claims.json?#{query.to_query}", cookies: cookies_hash)
        JSON.parse(claims.body).map(&:with_indifferent_access)
      end

      def find_latest_claim
        claims.last
      end

      def respondents_api
        login
        claimants = request(:get, "#{url}/respondents.json", cookies: cookies_hash)
        JSON.parse(claimants.body).map(&:with_indifferent_access)
      end

      def claimants_api
        login
        claimants = request(:get, "#{url}/claimants.json", cookies: cookies_hash)
        JSON.parse(claimants.body).map(&:with_indifferent_access)
      end

      def acas_certificate_logs_api
        login
        acas_logs = request(:get, "#{url}/download_logs.json", cookies: cookies_hash)
        JSON.parse(acas_logs.body).map(&:with_indifferent_access)
      end

      def external_systems(query = {})
        login
        external_systems = request(:get, "#{url}/external_systems.json?#{query.to_query}", cookies: cookies_hash)
        JSON.parse(external_systems.body).map(&:with_indifferent_access)
      end

      def office_postcodes(query = {})
        mechanize_login
        response = agent.get("#{url}/office_postcodes.json?#{query.to_query}", 'Accept' => 'application/json')
        JSON.parse(response.body).map(&:with_indifferent_access)
      end

      def offices(query = {})
        mechanize_login
        response = agent.get("#{url}/et_offices.json?per_page=50&#{query.to_query}", 'Accept' => 'application/json')
        JSON.parse(response.body).map(&:with_indifferent_access)
      end

      def delete_user_by_email(email)
        mechanize_login
        query = { q: { email_eq: email } }
        response_for_csrf = agent.get("#{url}/users?#{query.to_query}")
        csrf_token = response_for_csrf.search('meta[name=csrf-token]').first['content']
        response = agent.get("#{url}/users.json?#{query.to_query}")
        users = JSON.parse(response.body).map(&:with_indifferent_access)
        user_record = users.first
        return if user_record.nil?

        agent.post("#{url}/users/#{user_record[:id]}.json", {_method: 'delete'}, 'Accept' => 'application/json', 'X-CSRF-Token' => csrf_token)
      end



      def find_office_postcode(postcode, timeout: 5, sleep: 0.1, raise: false)
        wait_for(timeout: timeout, sleep: sleep, raise: raise) do
          office_postcodes(q: {postcode_eq: postcode}).first
        end
      end

      def responses(query = {})
        login
        responses = request(:get, "#{url}/responses.json?#{query.to_query}", cookies: cookies_hash)
        JSON.parse(responses.body).map(&:with_indifferent_access)
      end

      def processed_response(reference, timeout: 30, sleep: 0.5)
        login
        Timeout.timeout(timeout) do
          loop do
            responses = responses q: {reference_eq: reference}
            return responses.first if responses.first[:uploaded_files].any? {|f| f['filename'] =~ /\Aet3_.*\.pdf\z/}
            sleep(sleep)
          end
        end
      rescue Timeout::Error
        raise "The response with reference #{reference} was either not found or never had all of its files"
      end

      def exported_to_ccd_claim(reference:, timeout: 30, sleep: 0.5)
        login
        Timeout.timeout(timeout) do
          loop do
            claims = claims q: {reference_eq: reference}
            return claims.first if claims.first['ecm_state'].start_with?('complete')
            sleep(sleep)
          end
        end
      rescue Timeout::Error
        raise "The claim with reference #{reference} was either not found or was never successfully exported to ccd"
      end

      def admin_diversity_data
        login
        response = request(:get, "#{url}/diversity_responses.json?
          claim_type_cont=data[:claim_type]
          &sex_cont=data[:sex_contains]
          &sexual_identity_cont=data[:sexual_identity]
          &age_group_cont=data[:age_group]
          &ethnicity_cont=data[:ethnicity]
          &ethnicity_subgroup_cont=data[:ethnicity_subgroup]
          &disability_cont=data[:disability]
          &caring_responsibility_cont=data[:caring_responsibility]
          &gender_cont=data[:gender]
          &gender_at_birth_cont=data[:gender_at_birth]
          &pregnancy_cont=data[:pregnancy]
          &relationship_cont=data[:relationship]
          &religion_cont=data[:religion]", cookies: cookies_hash)
        response[0].delete_if { |k, v| %w"id created_at updated_at".include? k}
      end

      def export_response_to_ccd(external_system_id:, response_reference:)
        response = processed_response(response_reference)
        mechanize_login
        #  {"utf8"=>"✓", "authenticity_token"=>"r5OI+QKjssqdg7YkdFI2pHxVTD+xi82wGjaLQQA0/J7O7OC6gBi7gzoywY08yV9rXBO3kFR0yloBMY1ALjPXyg==", "batch_action"=>"export", "batch_action_inputs"=>"{\"external_system_id\":\"17\"}", "collection_selection_toggle_all"=>"on", "collection_selection"=>["1"], "q"=>{"reference_eq"=>"242000000200"}}
        p = agent.current_page
        # <meta name="csrf-token" content="ytwP931nOlzYVWOENBNJHKk8J3uL6iZElQ4Pr9lz++nZOdQuDsBUQjkCNh8ZWdE5cJxcAGyql11WANN
        token = p.search('meta[name=csrf-token]').first['content']

        result = agent.post "#{url}/responses/batch_action",
                   {
                       batch_action: 'export',
                       batch_action_inputs: {external_system_id: external_system_id}.to_json,
                       collection_selection: [response[:id].to_s],
                       authenticity_token: token
                   }.to_json,
                  'Content-Type' => 'application/json',
                  'Accept' => 'text/html'
        raise "export_response_to_ccd failed" if result.search(XPath.generate {|x| x.descendant[x.string.n.contains("Responses queued for export")]}.to_s).empty?
      end


      def run_export_cron_job
        setup_for_export_cron_job
        sidekiq_cron_agent.current_page.form(action: "/admin/sidekiq/cron/export_claims_job/enque").submit
      end

      def processed_claim(claim_reference:, timeout: 30, sleep: 0.5)
        login
        Timeout.timeout(timeout) do
          loop do
            filtered_claims = claims q: {reference_eq: claim_reference}
            return filtered_claims.first if filtered_claims.first.present? && filtered_claims.first[:uploaded_files].any? {|f| f['filename'] =~ /\Aet1_.*\.pdf\z/}
            sleep(sleep)
          end
        end
      rescue Timeout::Error
        raise "The claim with application reference #{claim_reference} was either not found or never had all of its files"
      end

      def wait_for_claim_failed_in_ccd_export(reference, timeout: 30, sleep: 0.5)
        login
        filtered_claims = []
        Timeout.timeout(timeout) do
          loop do
            filtered_claims = claims q: {reference_eq: reference}
            return filtered_claims.first if filtered_claims.first.present? && filtered_claims.first[:ecm_state] == 'failed'
            yield filtered_claims.first if block_given?
            sleep(sleep)
          end
        end
      rescue Timeout::Error
        raise "The claim with reference #{reference} was not found" if filtered_claims.empty?
        raise "The claim with reference #{reference} never had a status of 'failed'"
      end

      def wait_for_claim_erroring_in_ccd_export(reference, timeout: 30, sleep: 0.5)
        login
        Timeout.timeout(timeout) do
          loop do
            filtered_claims = claims q: {reference_eq: reference}
            return filtered_claims.first if filtered_claims.first.present? && filtered_claims.first[:ecm_state] == 'erroring'
            yield if block_given?
            sleep(sleep)
          end
        end
      rescue Timeout::Error
        raise "The claim with reference #{reference} was either not found or never had a status of 'erroring'"
      end

      def wait_for_claim_success_in_ccd_export(reference, timeout: 30, sleep: 0.5)
        login
        Timeout.timeout(timeout) do
          loop do
            filtered_claims = claims q: {reference_eq: reference}
            return filtered_claims.first if filtered_claims.first.present? && filtered_claims.first[:ecm_state] == 'complete'
            yield if block_given?
            sleep(sleep)
          end
        end
      rescue Timeout::Error
        raise "The claim with reference #{reference} was either not found or never had a status of 'complete'"
      end

      def wait_for_response_success_in_ccd_export(case_number:, timeout: 30, sleep: 0.5)
        login
        Timeout.timeout(timeout) do
          loop do
            filtered_responses = responses q: {case_number_eq: case_number}
            return filtered_responses.first if filtered_responses.first.present? && filtered_responses.first[:ecm_state] == 'complete'
            sleep(sleep)
          end
        end
      rescue Timeout::Error
        raise "The response with case_number #{case_number} was either not found or never had a status of 'complete'"
      end

      def office_data_for(office_code)
        cached_office_data.detect {|office_data| office_data['code'].to_s == office_code}
      end

      def cached_office_data
        Thread.current[:admin_api_cached_office_data] ||= offices
      end

      def wait_for_response_in_office(response_reference, office_code, timeout: 30, sleep: 0.5)
        login
        office = office_data_for(office_code)
        Timeout.timeout(timeout) do
          loop do
            response = admin_api.responses(q: {office_id_eq: office['id'], reference_cont: @my_et3_reference}).first
            return response if response.present?

            sleep 5
          end
        end
      rescue Timeout::Error
        raise "The response with reference '#{response_reference}' was not found in office code '#{office_code}'"
      end

      private

      def wait_for(timeout: 5, sleep: 0.1, raise: true)
        Timeout.timeout(timeout) do
          loop do
            result = yield
            return result unless result.nil?
            sleep(sleep)
          end
        end
      rescue Timeout::Error
        raise "wait_for timed out waiting for #{timeout} seconds" if raise
        nil
      end

      def logged_in?
        logged_in
      end

      def mechanize_logged_in?
        mechanize_logged_in
      end

      def setup_for_export_cron_job
        return if sidekiq_cron_agent.present?
        mechanize_login
        self.sidekiq_cron_agent = Mechanize.new do |a|
          a.cookie_jar = agent.cookie_jar
        end
        sidekiq_cron_agent.get("#{url}/sidekiq/cron")
        sidekiq_cron_agent.click "Cron"


      end

      def request(method, url, options = {})
        proxy = EtFullSystem::Test::Configuration['proxy']
        options = options.merge(verify: false)
        if proxy
          proxy_uri = URI.parse("http://#{proxy}")
          options[:http_proxyaddr] = proxy_uri.host
          options[:http_proxyport] = proxy_uri.port
          options[:http_proxyuser] = proxy_uri.user
          options[:http_proxypass] = proxy_uri.password
        end
        self.last_response = HTTParty.send(method, url, options)
        self.cookies_hash = HTTParty::CookieHash.new
        cookies_hash.add_cookies(last_response.headers['set-cookie'])
        last_response
      end

      def agent
        @agent ||= Mechanize.new
      end

      attr_accessor :sidekiq_cron_agent, :cookies_hash, :last_response, :csrf_token, :sidekiq_authenticity_token, :sidekiq_cron_form_url, :logged_in, :mechanize_logged_in
    end
  end
end
