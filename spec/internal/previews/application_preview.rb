# frozen_string_literal: true

# @hidden
class ApplicationPreview < ViewComponent::Preview
  private

  # Renders the block's fields in a `form_with model:`, through ViewComponent::Form's builder
  def form(model = User.new, &fields)
    render FormPreviewComponent.new(model: model, fields: fields)
  end
end
