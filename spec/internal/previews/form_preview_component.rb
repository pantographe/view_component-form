# frozen_string_literal: true

# Renders the previews' fields inside a real `form_with`, as an app would
class FormPreviewComponent < ViewComponent::Base
  def initialize(model:, fields:)
    super()
    @model = model
    @fields = fields
  end

  def call
    helpers.form_with(model: @model, url: "#", builder: ViewComponent::Form::Builder) { |f| @fields.call(f) }
  end
end
