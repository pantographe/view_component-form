# frozen_string_literal: true

module ViewComponent
  module Form
    class SubmitComponent < BaseComponent
      attr_reader :value

      def initialize(form, object_name, value, options = {})
        @value = value

        super(form, object_name, options)
      end

      def call
        submit_tag(value, options)
      end
    end
  end
end
