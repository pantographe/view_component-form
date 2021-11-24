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

      if Gem::Version.new(Rails::VERSION::STRING) >= Gem::Version.new("6.1")
        def template
          lookup_context = ActionView::LookupContext.new(ActionController::Base.view_paths)

          ActionView::Base.new(lookup_context, {}, ApplicationController.new)
        end
      else
        def template
          lookup_context = ActionView::LookupContext.new(ActionController::Base.view_paths)

          ActionView::Base.new(lookup_context, {})
        end
      end
    end
  end
end
