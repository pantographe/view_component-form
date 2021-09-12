# frozen_string_literal: true

module InlineForm
  class LabelComponent < ViewComponent::Form::LabelComponent
    def call
      "my custom label for inline form"
    end
  end
end
