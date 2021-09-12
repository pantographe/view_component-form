# frozen_string_literal: true

require "action_controller"
require "action_controller/test_case"
require "action_view"

module ViewComponent
  module Form
    module TestHelpers
      include ActionView::ModelNaming

      # See: https://github.com/rails/rails/blob/83217025a171593547d1268651b446d3533e2019/actionview/lib/action_view/helpers/form_helper.rb#L737
      def form_with(model: nil, scope: nil, **options)
        if model
          model   = model.last if model.is_a?(Array)
          scope ||= model_name_from_record_or_class(model).param_key
        end

        instanciate_form_builder(scope, model, options)
      end

      # See: https://github.com/rails/rails/blob/83217025a171593547d1268651b446d3533e2019/actionview/lib/action_view/helpers/form_helper.rb#L1561
      def instanciate_form_builder(record_name, record_object = nil, **options)
        case record_name
        when String, Symbol
          object = record_object
          object_name = record_name
        else
          object = record_name
          object_name = model_name_from_record_or_class(object).param_key if object
        end

        builder = options[:builder] || ViewComponent::Form::Builder
        builder.new(object_name, object, template, options)
      end

      private

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
