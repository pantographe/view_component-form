# frozen_string_literal: true

require "rubygems"
require "bundler"

Bundler.require :default, :development

require "view_component/engine"
require "lookbook"

Combustion.initialize! :all do
  config.logger = ActiveSupport::TaggedLogging.new(Logger.new(nil))
  config.log_level = :fatal
end

run Combustion::Application
