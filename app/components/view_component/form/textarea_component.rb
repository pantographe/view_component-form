# frozen_string_literal: true

module ViewComponent
  module Form
    class TextareaComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::TextArea
    end
  end
end
