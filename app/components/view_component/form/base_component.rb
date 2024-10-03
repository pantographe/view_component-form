# frozen_string_literal: true

module ViewComponent
  module Form
    class BaseComponent < ViewComponent::Form.configuration.parent_component.constantize
      class << self
        attr_accessor :default_options
      end

      include ClassNamesHelper if Gem::Version.new(Rails::VERSION::STRING) < Gem::Version.new("6.1")

      attr_reader :form, :object_name, :options

      delegate :object, to: :form, allow_nil: true

      def initialize(form, object_name, options = {})
        @form = form

        # See: https://github.com/rails/rails/blob/83217025a171593547d1268651b446d3533e2019/actionview/lib/action_view/helpers/tags/base.rb#L13
        @object_name = object_name.to_s.dup
        @options     = options

        super()
      end

      def object_errors?
        return false unless object

        object.errors.any?
      end

      def object_errors
        return nil unless object

        object.errors
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
