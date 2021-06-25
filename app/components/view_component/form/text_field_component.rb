# frozen_string_literal: true

module ViewComponent
  module Form
    class TextFieldComponent < FieldComponent
      self.tag_klass = Tags::TextField
    end
  end
end
