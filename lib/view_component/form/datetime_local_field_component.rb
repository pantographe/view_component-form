# frozen_string_literal: true

module ViewComponent
  module Form
    class DatetimeLocalFieldComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::DatetimeLocalField
    end
  end
end
