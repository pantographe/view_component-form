# frozen_string_literal: true

module ViewComponent
  module Form
    class DateFieldComponent < FieldComponent
      self.tag_klass = Tags::DateField
    end
  end
end
