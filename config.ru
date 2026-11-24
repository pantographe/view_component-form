# frozen_string_literal: true

# Component previews with Lookbook: `bundle exec rackup`, then http://localhost:9292
ENV["RAILS_ENV"] = "development" # Combustion then requires the :development group, with Lookbook

require "bundler/setup"
require "combustion"

Dir.chdir(__dir__) # Combustion finds spec/internal from the current directory

Combustion.initialize! :active_model, :action_controller, :action_view do
  config.load_defaults Rails::VERSION::STRING.to_f
  config.enable_reloading = true
  # Outside test/components/previews, so the spec suite doesn't autoload them
  config.view_component.previews.paths << Rails.root.join("previews").to_s
  config.lookbook.project_name = "ViewComponent::Form"
end

# Once Action View is loaded, as in spec/spec_helper.rb
require "country_select"

run Combustion::Application
