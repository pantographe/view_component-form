# frozen_string_literal: true

if ENV.fetch("COVERAGE", false)
  require "simplecov"
  SimpleCov.start do
    add_filter "/spec"

    minimum_coverage 89
    maximum_coverage_drop 2
  end
end

require "view_component/engine"
require "view_component/form"

require "combustion"

Combustion.path = "spec/internal"

modules = %i[action_controller action_view active_record active_storage]
modules << :action_text if ENV.fetch("VIEW_COMPONENT_FORM_USE_ACTIONTEXT", "false") == "true"

Combustion.initialize!(*modules) do
  config.logger = ActiveSupport::TaggedLogging.new(Logger.new(nil))
  config.log_level = :fatal
end

require "generator_spec"

class ApplicationController < ActionController::Base
end

require "view_component/test_helpers"
require "view_component/form/test_helpers"
require "capybara/rspec"
require "ostruct"

Dir["./spec/support/**/*.rb"].each { |f| require f }

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

  config.include ActiveSupport::Testing::TimeHelpers

  config.after { travel_back }
end
