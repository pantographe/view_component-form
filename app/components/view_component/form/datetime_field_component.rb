# frozen_string_literal: true

module ViewComponent
  module Form
    class DatetimeFieldComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::DatetimeField
    end
  end
end
