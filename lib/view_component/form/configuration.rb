# frozen_string_literal: true

module ViewComponent
  module Form
    class Configuration
      attr_accessor :parent_component, :lookup_chain

      def initialize
        @parent_component = "ViewComponent::Base"
        @lookup_chain = [
          lambda do |component_name, namespaces: []|
            namespaces.lazy.map do |namespace|
              "#{namespace}::#{component_name.to_s.camelize}Component".safe_constantize
            end.find(&:itself)
          end
        ]
      end
    end
  end
end
