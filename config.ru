# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "development"

require "rubygems"
require "bundler"

Bundler.require(:default, :development)

Combustion.initialize! :all do
  config.logger = ActiveSupport::TaggedLogging.new(Logger.new(nil))
  config.log_level = :fatal

  config.view_component.preview_paths << Rails.root.join("test/components/previews")
  config.view_component.default_preview_layout = "component_preview"

  config.lookbook.listen_paths << Rails.root.join("../../app/components")
end

run Combustion::Application
