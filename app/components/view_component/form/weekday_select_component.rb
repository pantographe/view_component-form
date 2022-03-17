# frozen_string_literal: true

module ViewComponent
  module Form
    class WeekdaySelectComponent < FieldComponent
      attr_reader :html_options

      def initialize(form, object_name, method_name, options = {}, html_options = {})
        @html_options = html_options

        super(form, object_name, method_name, options)

        set_html_options!
      end

      def call # rubocop:disable Metrics/MethodLength
        if Rails::VERSION::MAJOR >= 7 # rubocop:disable Style/GuardClause
          ActionView::Helpers::Tags::WeekdaySelect.new(
            object_name,
            method_name,
            @view_context,
            options,
            html_options
          ).render
        else
          raise NotImplementedError, "#{self.class} is only available in Rails >= 7"
        end
      end

      protected

      def set_html_options!
        @html_options[:class] = class_names(html_options[:class], html_class)
        @html_options.delete(:class) if @html_options[:class].blank?
      end
    end
  end
end
