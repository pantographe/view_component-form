# frozen_string_literal: true

require "action_controller"
require "action_controller/test_case"
require "action_view"

module ViewComponent
  module Form
    module TestHelpers
      def form_with(object, options = {})
        ViewComponent::Form::Builder.new(object_name, object, template, options)
      end

      def object_name
        :user
      end

      def template
        lookup_context = ActionView::LookupContext.new(ActionController::Base.view_paths)

        if Gem::Version.new(Rails::VERSION::STRING) >= Gem::Version.new("6.1")
          ActionView::Base.new(lookup_context, {}, ApplicationController.new)
        else
          ActionView::Base.new(lookup_context, {})
        end
      end
    end
  end
end
