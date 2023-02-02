# frozen_string_literal: true

module ViewComponent
  module Form
    module Helpers
      module RailsBackports
        # Backport field_id from Rails 7.0
        if ::Rails::VERSION::MAJOR < 7
          def field_id(method_name, *suffixes, namespace: @options[:namespace], index: @index)
            object_name = object_name.model_name.singular if object_name.respond_to?(:model_name)

            sanitized_object_name = object_name.to_s.gsub(/\]\[|[^-a-zA-Z0-9:.]/, "_").delete_suffix("_")

            sanitized_method_name = method_name.to_s.delete_suffix("?")

            [
              namespace,
              sanitized_object_name.presence,
              (index unless sanitized_object_name.empty?),
              sanitized_method_name,
              *suffixes
            ].tap(&:compact!).join("_")
          end
        end
      end
    end
  end
end
