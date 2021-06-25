# frozen_string_literal: true

module ViewComponent
  module Form
    class WeekFieldComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::WeekField
    end
  end
end
