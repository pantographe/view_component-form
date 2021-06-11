# frozen_string_literal: true

module ViewComponent
  module Form
    class BaseComponent < ApplicationComponent
      class << self
        attr_accessor :default_options
      end

      # include Components::Validations

      # validates :form, presence: true
      # validates :object_name, presence: true

      attr_reader :form, :object_name, :options, :theme

      delegate :object, to: :form
      delegate :errors, to: :object, prefix: true

      def initialize(form, object_name, options = {})
        @form         = form
        @object_name  = object_name
        @theme        = options.delete(:theme)
        @options      = options

        super()
      end

      def object_errors?
        object.errors.any?
      end

      def html_class
        nil
      end

      protected

      def before_render
        super

        combine_options!
      end

      def combine_options!
        @options = (self.class.default_options.deep_dup || {}).deep_merge(options).tap do |opts|
          opts[:class] = class_names(options[:class], html_class) if (html_class || options[:class]).present?
        end
      end
    end
  end
end
