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
      include ViewComponent::Form::Helpers::RailsBackports
      include ViewComponent::Form::Helpers::Custom

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
