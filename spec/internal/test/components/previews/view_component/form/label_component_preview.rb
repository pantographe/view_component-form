# frozen_string_literal: true

module ViewComponent
  module Form
    class LabelComponentPreview < ViewComponent::Preview
      def test
        render ViewComponent::Form::LabelComponent.new(form_builder, object_name, :first_name)
      end

      private

      def form_builder
        @form_builder ||= ViewComponent::Form::Builder.new(object_name, object, template, {})
      end

      def object
        OpenStruct.new
      end

      def object_name
        :user
      end

      def template
        lookup_context = ActionView::LookupContext.new(ActionController::Base.view_paths)

        if Gem::Version.new(Rails::VERSION::STRING) >= Gem::Version.new("6.1")
          ActionView::Base.new(lookup_context, {}, ActionController::Base.new)
        else
          ActionView::Base.new(lookup_context, {})
        end
      end
    end
  end
end
