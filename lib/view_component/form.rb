# frozen_string_literal: true

require "view_component"

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
form = "#{__dir__}/form.rb"
loader.ignore(form)
loader.push_dir("#{__dir__}/form", namespace: ViewComponent::Form)
loader.push_dir("#{__dir__}/../../app/components")
loader.setup
