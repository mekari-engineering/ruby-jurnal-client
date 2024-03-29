require "bundler/setup"
require "jurnal_api"
require "capybara/rspec"
require "webmock/rspec"
require "json"
require "support/fixture_support"
require "support/stubber_support"

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.include FixtureSupport
  config.include StubberSupport

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = 'random'
end
