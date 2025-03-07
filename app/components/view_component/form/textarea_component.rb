# frozen_string_literal: true

module ViewComponent
  module Form
    class TextareaComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::TextArea
    end

    TextAreaComponent = TextareaComponent if Gem::Version.new(::Rails::VERSION::STRING) < Gem::Version.new("8.0")
  end
end
