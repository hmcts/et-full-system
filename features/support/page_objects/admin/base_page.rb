require 'rspec/matchers'
module EtFullSystem
  module Test
    module Admin
      class BasePage < ::EtFullSystem::Test::BasePage
        include ::RSpec::Matchers
        element :csrf_param, :css, 'meta[name=csrf-param]'
        element :csrf_token, :css, 'meta[name=csrf-token]'
        elements :names, '.header ul li a'
        section :menu, '.header' do
          element :dashboard_menu_item, :link, 'Dashboard'
          element :acas_menu_item, :link, 'Acas'
          element :acas_certificates_menu_item, :link, 'Certificate Search'
          element :addresses_menu_item, :link, 'Addresses'
          element :atos_files_menu_item, :link, 'Atos Files'
          element :claimants_menu_item, :link, 'Claimants'
          element :claims_menu_item, :link, 'Claims'
          element :diversity_responses_menu_item, :link, 'Diversity Responses'
          element :et_offices_menu_item, :link, 'Et Offices'
          element :exported_files_menu_item, :link, 'Exported Files'
          element :exports_menu_item, :link, 'Exports'
          element :generate_references_menu_item, :link, 'Generate References'
          element :jobs_menu_item, :link, 'Jobs'
          element :office_postcodes_menu_item, :link, 'Office Postcodes'
          element :permissions_menu_item, :link, 'Permissions'
          element :representatives_menu_item, :link, 'Representatives'
          element :respondents_menu_item, :link, 'Respondents'
          element :roles_menu_item, :link, 'Roles'
          element :uploaded_files_menu_item, :link, 'Uploaded Files'
          element :users_menu_item, :link, 'Users'
          def choose_acas_certificates
            acas_menu_item.hover
            acas_certificates_menu_item.click
          end

          def click_office_postcodes
            office_postcodes_menu_item.click
          end

          def click_generate_references
            generate_references_menu_item.click
          end

          def click_users
            users_menu_item.click
          end

          def click_claims
            claims_menu_item.click
          end
        end
        def self.base_url
          Configuration.admin_url
        end

        def self.set_url(url, *args)
          super("#{base_url}#{url}", *args)
        end

        def full_access
          ["Dashboard",
            "Acas",
            "",
            "",
            "Addresses",
            "Atos Files",
            "Claimants",
            "Claims",
            "Commands",
            "Default Office Claims",
            "Diversity Responses",
            "Et Offices",
            "Exported Files",
            "Exports",
            "External Systems",
            "Generate References",
            "Jobs",
            "Office Postcodes",
            "Permissions",
            "Reports",
            "",
            "Representatives",
            "Respondents",
            "Responses",
            "Roles",
            "Uploaded Files",
            "Users",
            "",
            "Logout"]
        end

        def partial_access
          ["Dashboard",
            "Acas",
            "",
            "",
            "Claims",
            "Et Offices",
            "Generate References",
            "Office Postcodes",
            "Responses",
            "Roles",
            "Users",
            "",
            "Logout"]
        end

        def basic_access
          ["Dashboard",
            "Acas",
            "",
            "",
            "Et Offices",
            "Generate References",
            "Logout"]
        end
        section :utility_nav, '#header ul#utility_nav' do
          element :logout_menu_item, :link, 'Logout'

          def click_logout
            logout_menu_item.click
          end
        end

        private

        def admin_api
          @admin_api ||= EtFullSystem::Test::AdminApi.new
        end

        def wait_for(timeout: 0.5, sleep: 0.05)
          Timeout.timeout(timeout) do
            loop do
              result = yield
              break result if result
              sleep sleep
            end
          end
        rescue Timeout::Error
          raise "Waited for #{timeout} but the condition was never true"
        end

        def ajax_get(url)
          script = <<-JS
            window.EtFullSystem = window.EtFullSystem || {};
            window.EtFullSystem.Test = window.EtFullSystem.Test || {};
            window.EtFullSystem.Test.getRequester = function(url) {
              this.xhr = new XMLHttpRequest();
              this.error = null;
              this.response = null;
              this.ready = false;
              this.xhr.onload = function() {
                this.ready = true;
                if (this.xhr.status != 200) { // analyze HTTP status of the response
                  this.error = "Error " + this.xhr.status + " " + this.xhr.statusText; // e.g. 404: Not Found
                } else { // show the result
                  this.response = this.xhr.response;
                }
              }.bind(this);
              
              this.xhr.onerror = function() {
                this.ready = true;
                this.error = "Request failed";
              }.bind(this);
              this.xhr.open('GET', url, true);
              this.xhr.setRequestHeader('Accept', 'application/json');
            };
            window.EtFullSystem.Test.getRequester.prototype.makeRequest = function() {
              this.xhr.send();
            };
          JS
          execute_script(script)
          script = "window.EtFullSystem.Test.currentRequester = new EtFullSystem.Test.getRequester('#{url}'); window.EtFullSystem.Test.currentRequester.makeRequest();"
          execute_script(script)
          wait_for timeout: 1, sleep: 0.05 do
            execute_script('return window.EtFullSystem.Test.currentRequester.ready');
          end
          error = execute_script('return window.EtFullSystem.Test.currentRequester.error')
          raise "An error occurred performing a GET on #{url} - The error was #{error}" if error
          execute_script('return window.EtFullSystem.Test.currentRequester.response')
        end

        def ajax_delete(url)
          script = <<-JS
            window.EtFullSystem = window.EtFullSystem || {};
            window.EtFullSystem.Test = window.EtFullSystem.Test || {};
            window.EtFullSystem.Test.deleteRequester = function(url, csrfParam, csrfToken) {
              this.xhr = new XMLHttpRequest();
              this.error = null;
              this.response = null;
              this.ready = false;
              this.csrfParam = csrfParam;
              this.csrfToken = csrfToken;
              this.xhr.onload = function() {
                this.ready = true;
                if (this.xhr.status != 200) { // analyze HTTP status of the response
                  this.error = "Error " + this.xhr.status + " " + this.xhr.statusText; // e.g. 404: Not Found
                } else { // show the result
                  this.response = this.xhr.response;
                }
              }.bind(this);
              
              this.xhr.onerror = function() {
                this.ready = true;
                this.error = "Request failed";
              }.bind(this);
              this.xhr.open('POST', url, true);
              this.xhr.setRequestHeader('Accept', 'application/json');
              this.xhr.setRequestHeader('Content-Type', 'application/json');
            };
            window.EtFullSystem.Test.deleteRequester.prototype.makeRequest = function() {
              var data = {
                _method: 'delete',
              };
              data[this.csrfParam] = this.csrfToken;
              this.xhr.send(JSON.stringify(data));
            };
          JS
          execute_script(script)
          script = "window.EtFullSystem.Test.currentRequester = new EtFullSystem.Test.deleteRequester('#{url}', '#{csrf_param[:content]}' ,'#{csrf_token[:content]}'); window.EtFullSystem.Test.currentRequester.makeRequest();"
          execute_script(script)
          wait_for timeout: 1, sleep: 0.05 do
            execute_script('return window.EtFullSystem.Test.currentRequester.ready');
          end
          error = execute_script('return window.EtFullSystem.Test.currentRequester.error')
          raise "An error occurred performing a DELETE on #{url} - The error was #{error}" if error
          execute_script('return window.EtFullSystem.Test.currentRequester.response')
        end
      end
    end
  end
end
