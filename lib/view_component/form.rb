# frozen_string_literal: true

require "view_component"
require_relative "form/configuration"
require "zeitwerk"

module ViewComponent
  module Form
    class << self
      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield configuration
      end
    end
  end
end

loader = Zeitwerk::Loader.for_gem
form = "#{__dir__}/form.rb"
loader.ignore(form)
loader.push_dir("#{__dir__}/form", namespace: ViewComponent::Form)
loader.setup

require_relative "form/engine"
