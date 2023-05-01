# frozen_string_literal: true

module ViewComponent
  module Form
    class CollectionCheckBoxesComponent < FieldComponent
      attr_reader :collection, :value_method, :text_method, :html_options

      def initialize( # rubocop:disable Metrics/ParameterLists
        form,
        object_name,
        method_name,
        collection,
        value_method,
        text_method,
        options = {},
        html_options = {}
      )
        @collection = collection
        @value_method = value_method
        @text_method = text_method
        @html_options = html_options

        super(form, object_name, method_name, options)

        set_html_options!
      end

      def call # rubocop:disable Metrics/MethodLength
        ActionView::Helpers::Tags::CollectionCheckBoxes.new(
          object_name,
          method_name,
          @view_context,
          collection,
          value_method,
          text_method,
          options,
          html_options,
          &content
        ).render
      end

      protected

      def set_html_options!
        @html_options[:class] = class_names(html_options[:class], html_class)
        @html_options.delete(:class) if @html_options[:class].blank?
      end

      # See: https://github.com/rails/rails/blob/83217025a171593547d1268651b446d3533e2019/actionview/lib/action_view/helpers/tags/collection_helpers.rb#L89
      def builder
        @builder ||= begin
          ActionView::Helpers::Tags::CollectionCheckBoxes::CheckBoxBuilder.new(@view_context, object_name, method_name, object, sanitize_attribute_name(value), text, value, input_html_options)
        end
      end
      delegate :translation, to: :builder

      def sanitize_attribute_name(value)
        "#{sanitized_method_name}_#{sanitized_value(value)}"
      end

      def sanitized_method_name
        @sanitized_method_name ||= @method_name.delete_suffix("?")
      end

      def sanitized_value(value)
        value.to_s.gsub(/[\s.]/, "_").gsub(/[^-[[:word:]]]/, "").downcase
      end
    end
  end
end
