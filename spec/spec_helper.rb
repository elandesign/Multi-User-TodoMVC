require "rspec"
require "rack/test"
require "database_cleaner"

ENV["RACK_ENV"] = "test"

require_relative "../config/boot"
require_relative "./support/helper_methods"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
  end

  config.before do
    self.class.send(:attr_accessor, :app)
    self.app = ApplicationController
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.include Rack::Test::Methods
  config.include SpecHelperMethods
end
