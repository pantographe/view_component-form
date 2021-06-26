# frozen_string_literal: true

module Form
  class SelectComponent < FieldComponent
    attr_reader :choices, :html_options

    def initialize(form, object_name, method_name, choices = nil, options = {}, html_options = {}) # rubocop:disable Metrics/ParameterLists
      @choices = choices
      @html_options = html_options

      super(form, object_name, method_name, options)

      set_html_options!
    end

    def call
      ActionView::Helpers::Tags::Select.new(object_name, method_name, form, choices, options, html_options, &content).render
    end

    protected

    def combine_options!
      @options = (self.class.default_options || {}).deep_merge(options)
    end

    def set_html_options!
      @html_options[:class] = class_names(html_options[:class], html_class)
    end
  end
end
