# frozen_string_literal: true

module ViewComponent
  module Form
    class Configuration
      attr_accessor :parent_component

      def initialize
        @parent_component = "ViewComponent::Base"
      end
    end
  end
end
