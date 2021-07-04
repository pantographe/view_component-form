# frozen_string_literal: true

module ViewComponent
  module Form
    class CollectionSelectComponent < FieldComponent
      attr_reader :collection, :value_method, :text_method, :html_options

      def initialize(form, object_name, method_name, collection, value_method, text_method, options = {}, html_options = {}) # rubocop:disable Metrics/ParameterLists
        @collection = collection
        @value_method = value_method
        @text_method = text_method
        @html_options = html_options

        super(form, object_name, method_name, options)

        set_html_options!
      end

      def call
        ActionView::Helpers::Tags::CollectionSelect.new(
          object_name,
          method_name,
          form,
          collection,
          value_method,
          text_method,
          options,
          html_options
        ).render
      end

      protected

      def set_html_options!
        @html_options[:class] = class_names(html_options[:class], html_class)
        @html_options.delete(:class) if @html_options[:class].blank?
      end
    end
  end
end
