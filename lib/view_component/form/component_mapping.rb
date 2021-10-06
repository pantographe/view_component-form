# frozen_string_literal: true

module ViewComponent
  module Form
    class ComponentMapping
      def initialize(mapping, template)
        @mapping = HashWithIndifferentAccess.new(mapping)
        @template = template
      end

      def method_missing(method_name, field_name = nil, *aargs, **kwargs)
        @mapping.fetch(remove_tag_suffix(method_name))
                .new(nil, field_name, *aargs, **kwargs)
                .render_in(@template, &block)
      end

      def respond_to_missing?(method_name, include_private = false)
        @mapping.key?(remove_tag_suffix(method_name)) || super
      end

      private

      def remove_tag_suffix(method_name)
        method_name.to_s.delete_suffix("_tag")
      end
    end
  end
end
