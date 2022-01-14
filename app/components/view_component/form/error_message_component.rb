# frozen_string_literal: true

module ViewComponent
  module Form
    class ErrorMessageComponent < FieldComponent
      class_attribute :tag, instance_reader: false, instance_writer: false, instance_accessor: false,
                            instance_predicate: false

      self.tag = :div

      def call
        tag.public_send(self.class.tag, messages, **options)
      end

      def render?
        method_errors?
      end

      def messages
        safe_join(method_errors, tag.br)
      end
    end
  end
end
