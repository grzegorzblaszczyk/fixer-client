require "bundler/setup"
require "pry"
require 'vcr'
require 'simplecov'
require 'simplecov-cobertura'
require 'simplecov-console'
require 'webmock'
require 'webmock/rspec'
require './spec/helpers/read_config_helpers'


unless ENV["VCR_OFF"] == "1"
  VCR.configure do |c|
    c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
    c.hook_into :webmock
  end
else
  WebMock.allow_net_connect!
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::CoberturaFormatter
])

SimpleCov.start

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.include ReadConfigHelpers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
