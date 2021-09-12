# frozen_string_literal: true

require "view_component/form/test_helpers"

module ViewComponent
  module Form
    class SubmitComponentPreview < ViewComponent::Preview
      include ViewComponent::Form::TestHelpers

      def default
        # TODO: maybe stop passing object_name to components since it is accessing from form_builder (delegate in BaseComponent)
        render ViewComponent::Form::SubmitComponent.new(form_builder, form_builder.object_name)
      end

      private

      def form_builder
        instanciate_form_builder(User.new)
      end
    end
  end
end
