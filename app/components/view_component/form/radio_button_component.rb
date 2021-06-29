# frozen_string_literal: true

module ViewComponent
  module Form
    class RadioButtonComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::RadioButton

      attr_reader :value

      def initialize(form, object_name, method_name, value, options = {})
        @value = value

        super(form, object_name, method_name, options)
      end

      def call
        ActionView::Helpers::Tags::RadioButton.new(
          object_name,
          method_name,
          form,
          value,
          options
        ).render
      end
    end
  end
end
