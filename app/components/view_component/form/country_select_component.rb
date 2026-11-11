# frozen_string_literal: true

module ViewComponent
  module Form
    # Renders the country_select gem's tag (https://github.com/countries/country_select), when it's installed
    class CountrySelectComponent < FieldComponent
      attr_reader :html_options

      def initialize(form, object_name, method_name, options = {}, html_options = {})
        @html_options = html_options

        super(form, object_name, method_name, options)

        set_html_options!
      end

      def call
        ActionView::Helpers::Tags::CountrySelect.new(
          object_name,
          method_name,
          @view_context,
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
