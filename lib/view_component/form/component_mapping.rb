# frozen_string_literal: true

module ViewComponent
  module Form
    class ComponentMapping
      def initialize(mapping)
        @mapping = HashWithIndifferentAccess.new(mapping)
      end

      def method_missing(method_name, _args = nil, *_aargs, **_kwargs)
        @mapping[method_name.to_s.delete_suffix("_tag")]
      end

      def respond_to_missing?(method_name, include_private = false)
        @mapping.key?(method_name.to_s.delete_suffix("_tag")) || super
      end
    end
  end
end
