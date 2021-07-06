# frozen_string_literal: true

module ViewComponent
  module Form
    class BaseComponent < ViewComponent::Base
      class << self
        attr_accessor :default_options
      end

      if Gem::Version.new(Rails::VERSION::STRING) < Gem::Version.new("6.1")
        require "view_component/form/class_names_helper"
        include ClassNamesHelper
      end

      attr_reader :form, :object_name, :options

      delegate :object, to: :form
      delegate :errors, to: :object, prefix: true

      def initialize(form, object_name, options = {})
        @form         = form
        @object_name  = object_name
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
