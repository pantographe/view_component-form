# frozen_string_literal: true

module ViewComponent
  module Form
    class ButtonComponent < BaseComponent
      attr_reader :value

      def initialize(form, object_name, value, options = {}, &block)
        @value = value

        if block_given?
          value = capture { yield(value) }
        end

        super(form, object_name, options)
      end

      def call
        button_tag(value, options)
      end
    end
  end
end
