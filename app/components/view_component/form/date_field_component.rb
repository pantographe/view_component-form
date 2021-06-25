# frozen_string_literal: true

module ViewComponent
  module Form
    class DateFieldComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::DateField
    end
  end
end
