require "rspec"
require "rack/test"
require "database_cleaner"

ENV["RACK_ENV"] = "test"

require_relative "../config/boot"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before :suite do
    DatabaseCleaner[:sequel, {connection: ::DB}].strategy = :transaction
    DatabaseCleaner[:sequel, {connection: ::DB}].clean_with(:truncation)
  end

  config.before do
    DatabaseCleaner[:sequel, {connection: ::DB}].start
  end

  config.after do
    DatabaseCleaner[:sequel, {connection: ::DB}].clean
  end

  config.include Rack::Test::Methods

  config.before do
    self.class.send(:attr_accessor, :app)
    self.app = ApplicationController
  end
end

def json_response
  JSON.parse(last_response.body)
end
