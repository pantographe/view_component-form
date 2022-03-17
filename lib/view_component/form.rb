# frozen_string_literal: true

require "view_component"
require "zeitwerk"

module ViewComponent
  module Form
  end
end

loader = Zeitwerk::Loader.for_gem
form = "#{__dir__}/form.rb"
loader.ignore(form)
loader.push_dir("#{__dir__}/form", namespace: ViewComponent::Form)
loader.setup

require_relative "form/engine"
