# frozen_string_literal: true

module ViewComponent
  module Form
    class Builder < ActionView::Helpers::FormBuilder
      class Error < StandardError; end

      class NotImplementedComponentError < Error; end

      class NamespaceAlreadyAddedError < Error; end

      class_attribute :lookup_namespaces, default: [ViewComponent::Form]

      class << self
        def inherited(base)
          base.lookup_namespaces = lookup_namespaces.dup

          super
        end

        def namespace(namespace)
          if lookup_namespaces.include?(namespace)
            raise NamespaceAlreadyAddedError, "The component namespace '#{namespace}' is already added"
          end

          lookup_namespaces.prepend namespace
        end
      end

      attr_reader :validation_context

      def initialize(*)
        @__component_klass_cache = {}

        super

        @validation_context = options[:validation_context]
      end

      include ViewComponent::Form::Helpers::Rails

      def error_message(method, options = {})
        render_component(:error_message, @object_name, method, objectify_options(options))
      end

      def hint(method, text = nil, options = {}, &block)
        render_component(:hint, @object_name, method, text, objectify_options(options), &block)
      end

      # Backport field_id from Rails 7.0
      if Rails::VERSION::MAJOR < 7
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

      private

      def render_component(component_name, *args, &block)
        component = component_klass(component_name).new(self, *args)
        component.render_in(@template, &block)
      end

      def objectify_options(options)
        @default_options.merge(options.merge(object: @object))
      end

      def component_klass(component_name)
        @__component_klass_cache[component_name] ||= begin
          component_klass = self.class.lookup_namespaces.filter_map do |namespace|
            "#{namespace}::#{component_name.to_s.camelize}Component".safe_constantize || false
          end.first

          unless component_klass.is_a?(Class) && component_klass < ViewComponent::Base
            raise NotImplementedComponentError, "Component named #{component_name} doesn't exist " \
                                                "or is not a ViewComponent::Base class"
          end

          component_klass
        end
      end
    end
  end
end
