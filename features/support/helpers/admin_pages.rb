module EtFullSystem
  module Test
    module AdminPages
      def self.dashboard_page
        Admin::DashboardPage.new
      end
      
      def self.login_page
        Admin::LoginPage.new
      end

      def self.logout_page
        Admin::LogoutPage.new
      end

      def self.jobs_page
        Admin::JobsPage.new
      end

      def self.any_page
        Admin::BasePage.new
      end

      def self.acas_search_page
        Admin::AcasSearchPage.new
      end

      def self.acas_search_results_page
        Admin::AcasSearchResultsPage.new
      end

      def self.claimants_page
        Admin::ClaimantsPage.new
      end


      # @return [::Admin::ClaimsPage] The page object for claims
      def self.claims_page
        Admin::ClaimsPage.new
      end

      # @return [::Admin::DefaultOfficeClaimsPage] The page object for claims
      def self.default_office_claims_page
        Admin::DefaultOfficeClaimsPage.new
      end

      # @return [::Admin::ExportPage] The page object for a single export
      def self.export_page
        Admin::ExportPage.new
      end

      def self.job_sidekiq_cron_page
        Admin::JobSidekiqCronPage.new
      end

      def self.atos_files_page
        Admin::AtosFilesPage.new
      end

      def self.office_postcodes_page
        Admin::OfficePostcodesPage.new
      end

      def self.new_office_postcodes_page
        Admin::NewOfficePostcodesPage.new
      end

      def self.generate_reference_number_page
        Admin::GenerateReferenceNumberPage.new
      end

      def self.generate_reference_result_page
        Admin::GenerateReferenceResultPage.new
      end

      def self.users_page
        Admin::UsersPage.new
      end

      def self.new_user_page
        Admin::NewUserPage.new
      end

      def self.import_file_page
        Admin::ImportFilePage.new
      end

      def self.diversity_responses_page
        Admin::DiversityResponsesPage.new
      end
    end
  end
end
