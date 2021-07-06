# frozen_string_literal: true

module ViewComponent
  module Form
    class ButtonComponent < BaseComponent
      attr_reader :value

      def initialize(form, value, options = {})
        @value = value

        super(form, nil, options)
      end

      def call
        button_tag(content || value, options)
      end
    end
  end
end
