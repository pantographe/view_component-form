# frozen_string_literal: true

module ViewComponent
  module Form
    class NumberFieldComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::NumberField
    end
  end
end
