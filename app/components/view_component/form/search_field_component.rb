# frozen_string_literal: true

module ViewComponent
  module Form
    class SearchFieldComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::SearchField
    end
  end
end
