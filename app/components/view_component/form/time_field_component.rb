# frozen_string_literal: true

module ViewComponent
  module Form
    class TimeFieldComponent < FieldComponent
      self.tag_klass = Tags::TimeField
    end
  end
end
