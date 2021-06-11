# frozen_string_literal: true

module ViewComponent
  module Form
    class TextFieldComponent < FieldComponent
      self.tag_klass = Tags::TextField

      def html_class
        class_names("field", "border-error": method_errors?)
      end
    end
  end
end
