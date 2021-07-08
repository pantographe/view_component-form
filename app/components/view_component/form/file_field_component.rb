# frozen_string_literal: true

module ViewComponent
  module Form
    class FileFieldComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::FileField
    end
  end
end
