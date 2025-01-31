# frozen_string_literal: true

module ViewComponent
  module Form
    class Builder < ActionView::Helpers::FormBuilder
      include ViewComponent::Form::Renderer
      include ViewComponent::Form::ValidationContext
      include ViewComponent::Form::Helpers::Rails
      include ViewComponent::Form::Helpers::Custom
    end
  end
end
