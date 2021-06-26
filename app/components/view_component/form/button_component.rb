# frozen_string_literal: true

module ViewComponent
  module Form
    class ButtonComponent < BaseComponent
      attr_reader :value

      def initialize(form, object_name, value, options = {})
        @value = value

        super(form, object_name, options)
      end

      def call
        button_tag(content || value, options)
      end
    end
  end
end
