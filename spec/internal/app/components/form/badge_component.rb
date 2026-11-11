# frozen_string_literal: true

module Form
  class BadgeComponent < ViewComponent::Form::FieldComponent
    def initialize(form, object_name, method_name, label:, **options)
      @label = label

      super(form, object_name, method_name, options)
    end

    def call
      content_tag(:span, @label, class: "badge-#{method_name}")
    end
  end
end
