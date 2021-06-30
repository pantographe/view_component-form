# frozen_string_literal: true

module ViewComponent
  module Form
    class CheckBoxComponent < FieldComponent
      attr_reader :checked_value, :unchecked_value

      def initialize(form, object_name, method_name, checked_value, unchecked_value, options = {}) # rubocop:disable Metrics/ParameterLists
        @checked_value   = checked_value
        @unchecked_value = unchecked_value

        super(form, object_name, method_name, options)
      end

      def call
        ActionView::Helpers::Tags::CheckBox.new(
          object_name,
          method_name,
          form,
          checked_value,
          unchecked_value,
          options
        ).render
      end
    end
  end
end
