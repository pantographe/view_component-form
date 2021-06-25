# frozen_string_literal: true

module ViewComponent
  module Form
    class LabelComponent < FieldComponent
      attr_reader :attribute_content

      def initialize(form, object_name, method_name, content_or_options = nil, options = nil)
        options ||= {}

        content_is_options = content_or_options.is_a?(Hash)
        if content_is_options
          options.merge! content_or_options
          @attribute_content = nil
        else
          @attribute_content = content_or_options
        end

        super(form, object_name, method_name, options)
      end

      def call
        content_or_options = nil

        content_or_options = content || attribute_content if content.present? || attribute_content.present?

        ActionView::Helpers::Tags::Label.new(object_name, method_name, form, content_or_options, options).render
      end
    end
  end
end
