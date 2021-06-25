# frozen_string_literal: true

module ViewComponent
  module Form
    class UrlFieldComponent < FieldComponent
      self.tag_klass = Tags::UrlField
    end
  end
end
