# frozen_string_literal: true

module ViewComponent
  module Form
    class RichTextAreaComponent < FieldComponent
      if defined?(ActionView::Helpers::Tags::ActionText)
        def call
          ActionView::Helpers::Tags::ActionText.new(object_name, method_name, @view_context, options)
                                               .render { content }
        end
      end
    end
  end
end
