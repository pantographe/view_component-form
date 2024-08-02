# frozen_string_literal: true

require "action_controller"
require "action_controller/test_case"
require "action_view"

module ViewComponent
  module Form
    module TestHelpers
      def form_with(object, builder: ViewComponent::Form::Builder, **options)
        object_name = if object.class.respond_to?(:model_name)
          object.class.model_name.param_key
        else
          :user
        end
  
        builder.new(object_name, object, template, options)
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
