# frozen_string_literal: true

require "rubygems"
require "bundler"

Bundler.require :default, :development

if ENV["VIEW_COMPONENT_FORM_USE_ACTIONTEXT"]
  Combustion.initialize! :all
else
  Combustion.initialize! :active_record, :action_controller, :action_view
end

run Combustion::Application
