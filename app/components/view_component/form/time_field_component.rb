# frozen_string_literal: true

module ViewComponent
  module Form
    class TimeFieldComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::TimeField
    end
  end
end
