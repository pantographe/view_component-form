# frozen_string_literal: true

module ViewComponent
  module Form
    class RangeFieldComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::RangeField
    end
  end
end
