# frozen_string_literal: true

require "action_controller"
require "action_controller/test_case"
require "action_view"

module ViewComponent
  module Form
    class TestView < ActionView::Base
      if defined?(ActionText)
        include ActionText::TagHelper
        # Rails 8.2+ `rich_textarea_tag` calls `main_app`; requires the Rails app to be initialized
        include Rails.application.routes.mounted_helpers
      end
    end

    module TestHelpers
      def form_with(object = nil, model: object, scope: nil, builder: ViewComponent::Form::Builder, **options)
        scope ||= model.class.respond_to?(:model_name) ? model.class.model_name.param_key : object_name

        builder.new(scope, model, template, options)
      end

      def object_name
        :user
      end

      def template
        lookup_context = ActionView::LookupContext.new(ActionController::Base.view_paths)

        TestView.new(lookup_context, {}, ApplicationController.new)
      end
    end
  end
end
