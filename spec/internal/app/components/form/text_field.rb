# frozen_string_literal: true

module Form
  class TextField < ViewComponent::Form::LabelComponent
    def call
      "my custom text_field"
    end
  end
end
