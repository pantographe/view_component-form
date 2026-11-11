# frozen_string_literal: true

module ViewComponent
  module Form
    class TelephoneFieldComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::TelField
    end
  end
end
