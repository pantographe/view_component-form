# frozen_string_literal: true

module ViewComponent
  module Form
    class PasswordFieldComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::PasswordField
    end
  end
end
