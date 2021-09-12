# frozen_string_literal: true

module Form
  class LabelComponent < ViewComponent::Form::LabelComponent
    def call
      "my custom label"
    end
  end
end
