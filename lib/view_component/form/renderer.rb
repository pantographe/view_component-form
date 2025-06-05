# frozen_string_literal: true

module ViewComponent
  module Form
    module Renderer
      class Error < StandardError; end
      class NamespaceAlreadyAddedError < Error; end
      class NotImplementedComponentError < Error; end

      # rubocop:disable Metrics/MethodLength
      def self.included(base)
        base.class_eval do
          original_initialize_method = instance_method(:initialize)

          define_method(:initialize) do |*args, &block|
            @__component_klass_cache = {}

            original_initialize_method.bind_call(self, *args, &block)
          end

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
        end
      end
      # rubocop:enable Metrics/MethodLength

      private

      def render_component(component_name, *args, &)
        component = component_klass(component_name).new(self, *args)
        component.render_in(@template, &)
      end

      def objectify_options(options)
        @default_options.merge(options.merge(object: @object))
      end

      def component_klass(component_name)
        @__component_klass_cache[component_name] ||= begin
          component_klass = ViewComponent::Form.configuration.lookup_chain.lazy.map do |lookup|
            lookup.call(component_name, namespaces: lookup_namespaces)
          end.find(&:itself)

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
