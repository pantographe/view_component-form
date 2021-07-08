# frozen_string_literal: true

module ViewComponent
  module Form
    class GroupedCollectionSelectComponent < FieldComponent
      attr_reader :collection, :group_method,
                  :group_label_method, :option_key_method, :option_value_method,
                  :html_options

      def initialize( # rubocop:disable Metrics/ParameterLists
        form,
        object_name,
        method_name,
        collection,
        group_method,
        group_label_method,
        option_key_method,
        option_value_method,
        options = {},
        html_options = {}
      )
        @collection = collection
        @group_method = group_method
        @group_label_method = group_label_method
        @option_key_method = option_key_method
        @option_value_method = option_value_method
        @html_options = html_options

        super(form, object_name, method_name, options)

        set_html_options!
      end

      def call # rubocop:disable Metrics/MethodLength
        ActionView::Helpers::Tags::GroupedCollectionSelect.new(
          object_name,
          method_name,
          form,
          collection,
          group_method,
          group_label_method,
          option_key_method,
          option_value_method,
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
