ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "faker"
require "minitest/mock"
require "aws-sdk-s3"

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include Devise::Test::IntegrationHelpers
  include ActionDispatch::TestProcess::FixtureFile
  include ActiveJob::TestHelper

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  setup do
    @site = create(:site, :example)
  end

  teardown do
    host! "www.example.com" if defined? host!
  end

  # Add more helper methods to be used by all tests here...
end
