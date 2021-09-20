# frozen_string_literal: true

if ENV.fetch("COVERAGE", false)
  require "simplecov"
  SimpleCov.start do
    minimum_coverage 90
    maximum_coverage_drop 2
  end
end

require "view_component/engine"
require "view_component/form"

require "combustion"

Combustion.path = "spec/internal"
Combustion.initialize! :action_controller, :action_view, :action_text do
  config.logger = ActiveSupport::TaggedLogging.new(Logger.new(nil))
  config.log_level = :fatal
end

class ApplicationController < ActionController::Base
end

require "view_component/test_helpers"
require "view_component/form/test_helpers"
require "capybara/rspec"

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include ViewComponent::TestHelpers, type: :component
  config.include ViewComponent::Form::TestHelpers, type: :component
  config.include ViewComponent::Form::TestHelpers, type: :builder
  config.include Capybara::RSpecMatchers, type: :component
  config.include RSpecHtmlMatchers, type: :component
end
