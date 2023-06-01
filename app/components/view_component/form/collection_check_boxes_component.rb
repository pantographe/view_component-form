# frozen_string_literal: true

module ViewComponent
  module Form
    class CollectionCheckBoxesComponent < FieldComponent
      attr_reader :collection, :value_method, :text_method, :html_options, :element_proc

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

        set_element_proc!
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
        ).render(&element_proc)
      end

      protected

      def set_element_proc!
        options_element_proc = options.delete(:element_proc)
        html_options_element_proc = html_options.delete(:element_proc)

        if options_element_proc && html_options_element_proc
          raise ArgumentError, "#{self.class.name} received :element_proc twice, expected only once"
        end

        @element_proc = options_element_proc || html_options_element_proc
      end

      def set_html_options!
        @html_options[:class] = class_names(html_options[:class], html_class)
        @html_options.delete(:class) if @html_options[:class].blank?
      end
    end
  end
end
