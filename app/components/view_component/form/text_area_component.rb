# frozen_string_literal: true

module ViewComponent
  module Form
    class TextAreaComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::TextArea
    end
  end
end
