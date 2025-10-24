# frozen_string_literal: true

module ViewComponent
  module Form
    class Builder < ActionView::Helpers::FormBuilder
      include ViewComponent::Form::Renderer
      include ViewComponent::Form::ValidationContext
      include ViewComponent::Form::Helpers::Rails

      if Gem::Version.new(::Rails::VERSION::STRING) >= Gem::Version.new("8.0")
        include ViewComponent::Form::Helpers::Rails8
      end
      include ViewComponent::Form::Helpers::Custom
    end
  end
end
