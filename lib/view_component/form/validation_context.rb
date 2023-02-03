# frozen_string_literal: true

module ViewComponent
  module Form
    module ValidationContext
      attr_reader :validation_context

      def self.included(base)
        base.class_eval do
          original_initialize_method = instance_method(:initialize)

          define_method(:initialize) do |*args, &block|
            original_initialize_method.bind_call(self, *args, &block)

            @validation_context = options[:validation_context]
          end
        end
      end
    end
  end
end
