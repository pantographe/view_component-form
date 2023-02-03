# frozen_string_literal: true

module ViewComponent
  module Form
    class Builder < ActionView::Helpers::FormBuilder
      class Error < StandardError; end
      class NotImplementedComponentError < Error; end
      class NamespaceAlreadyAddedError < Error; end

      include ViewComponent::Form::Renderer
      include ViewComponent::Form::ValidationContext

      def initialize(*)
        @__component_klass_cache = {}

        super

        # TODO: Not sure how to move this to ViewComponent::Form::ValidationContext
        @validation_context = options[:validation_context]
      end

      include ViewComponent::Form::Helpers::Rails
      include ViewComponent::Form::Helpers::RailsBackports
      include ViewComponent::Form::Helpers::Custom
    end
  end
end
