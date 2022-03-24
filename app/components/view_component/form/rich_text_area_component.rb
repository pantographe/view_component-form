# frozen_string_literal: true

module ViewComponent
  module Form
    class RichTextAreaComponent < FieldComponent
      if defined?(ActionView::Helpers::Tags::ActionText) # rubocop:disable Style/IfUnlessModifier
        self.tag_klass = ActionView::Helpers::Tags::ActionText
      end
    end
  end
end
