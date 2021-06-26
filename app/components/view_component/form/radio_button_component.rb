# frozen_string_literal: true

module ViewComponent
  module Form
    class RadioButtonComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::RadioButton
    end
  end
end
