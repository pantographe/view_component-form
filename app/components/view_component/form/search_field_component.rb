# frozen_string_literal: true

module ViewComponent
  module Form
    class SearchFieldComponent < FieldComponent
      self.tag_klass = Tags::SearchField
    end
  end
end
