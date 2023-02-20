# frozen_string_literal: true

require "view_component/form/test_helpers"

module ViewComponent
  module Form
    class LabelComponentPreview < ViewComponent::Preview
      include ViewComponent::Form::TestHelpers

      def default
        # TODO: maybe stop passing object_name to components since
        # it is accessing from form_builder (delegated in BaseComponent)
        render ViewComponent::Form::LabelComponent.new(form_builder, form_builder.object_name, :first_name)
      end

      private

      def form_builder
        instanciate_form_builder(User.new)
      end
    end
  end
end
