# frozen_string_literal: true

module ViewComponent
  module Form
    class ColorFieldComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::ColorField
    end
  end
end
