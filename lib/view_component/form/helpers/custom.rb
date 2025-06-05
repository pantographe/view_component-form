# frozen_string_literal: true

module ViewComponent
  module Form
    module Helpers
      module Custom
        def error_message(method, options = {})
          render_component(:error_message, @object_name, method, objectify_options(options))
        end

        def hint(method, text = nil, options = {}, &)
          render_component(:hint, @object_name, method, text, objectify_options(options), &)
        end
      end
    end
  end
end
