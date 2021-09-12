# frozen_string_literal: true

require "view_component/form/test_helpers"

module ViewComponent
  module Form
    class TextFieldComponentPreview < ViewComponent::Preview
      include ViewComponent::Form::TestHelpers

      def default
        @object = User.new

        # TODO: maybe stop passing object_name to components since it is accessing from form_builder (delegate in BaseComponent)
        render_f ViewComponent::Form::TextFieldComponent, :first_name
      end

      def with_value
        @object = User.new(first_name: "John")

        render_f ViewComponent::Form::TextFieldComponent, :first_name
      end


      private

      def render_f(component_klass, *args, **options)
        options[:object] ||= @object

        builder = instanciate_form_builder(options[:object])

        render component_klass.new(builder, builder.object_name, *args, options)
      end
    end
  end
end
