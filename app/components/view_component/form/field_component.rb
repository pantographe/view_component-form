# frozen_string_literal: true

module ViewComponent
  module Form
    class FieldComponent < BaseComponent
      class << self
        attr_accessor :tag_klass
      end

      attr_reader :method_name

      def initialize(form, object_name, method_name, options = {})
        # See: https://github.com/rails/rails/blob/83217025a171593547d1268651b446d3533e2019/actionview/lib/action_view/helpers/tags/base.rb#L13
        @method_name = method_name.to_s.dup

        super(form, object_name, options)
      end

      def call
        raise "`self.tag_klass' should be defined in #{self.class.name}" unless self.class.tag_klass

        self.class.tag_klass.new(object_name, method_name, @view_context, options).render
      end

      def method_errors
        return [] unless method_errors?

        @method_errors ||= object_errors.to_hash
                                        .fetch_values(*object_method_names) { nil }
                                        .flatten.compact
                                        .map(&:upcase_first)
      end

      def method_errors?
        (object_errors.keys & object_method_names).any?
      end

      def value
        object.public_send(method_name)
      end

      def object_method_names
        @object_method_names ||= begin
          object_method_names = [method_name]
          if method_name.end_with?("_id") && object.respond_to?(singular_association_method_name)
            object_method_names << singular_association_method_name
          elsif method_name.end_with?("_ids") && object.respond_to?(collection_association_method_name)
            object_method_names << collection_association_method_name
          end
          object_method_names
        end
      end

      private

      def singular_association_method_name
        @singular_association_method_name ||= method_name.to_s.sub(/_id$/, "").to_sym
      end

      def collection_association_method_name
        @collection_association_method_name ||= method_name.to_s.sub(/_ids$/, "").pluralize.to_sym
      end
    end
  end
end
