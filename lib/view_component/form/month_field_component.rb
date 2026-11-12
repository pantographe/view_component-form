# frozen_string_literal: true

module ViewComponent
  module Form
    class MonthFieldComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::MonthField
    end
  end
end
