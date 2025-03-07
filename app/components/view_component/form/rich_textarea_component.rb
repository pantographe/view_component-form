# frozen_string_literal: true

module ViewComponent
  module Form
    class RichTextareaComponent < FieldComponent
      if defined?(ActionView::Helpers::Tags::ActionText) # rubocop:disable Style/IfUnlessModifier
        self.tag_klass = ActionView::Helpers::Tags::ActionText
      end
    end

    if Gem::Version.new(::Rails::VERSION::STRING) < Gem::Version.new("8.0")
      RichTextAreaComponent = RichTextareaComponent
    end
  end
end
