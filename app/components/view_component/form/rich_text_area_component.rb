# frozen_string_literal: true

if defined?(ActionView::Helpers::Tags::ActionText)
  module ViewComponent
    module Form
      class RichTextAreaComponent < FieldComponent
        self.tag_klass = ActionView::Helpers::Tags::ActionText
      end
    end
  end
end
