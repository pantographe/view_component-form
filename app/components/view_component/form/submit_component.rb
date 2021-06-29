# frozen_string_literal: true

module ViewComponent
  module Form
    class SubmitComponent < BaseComponent
      attr_reader :value

      def initialize(form, value, options = {})
        @value = value
        @options = options

        super(form, nil, options)
      end

      def call
        submit_tag(value, options)
      end
    end
  end
end
