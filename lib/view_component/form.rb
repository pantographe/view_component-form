# frozen_string_literal: true

require_relative "form/version"
require "active_support/dependencies/autoload"

module ViewComponent
  module Form
    extend ActiveSupport::Autoload

    autoload :Builder
  end
end
