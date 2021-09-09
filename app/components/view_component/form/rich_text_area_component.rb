# frozen_string_literal: true

module ViewComponent
  module Form
    class RichTextAreaComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::ActionText
    end
  end
end
