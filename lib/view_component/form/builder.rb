# frozen_string_literal: true

require "action_view"

module ViewComponent
  module Form
    class Builder < ActionView::Helpers::FormBuilder
      class Error < StandardError; end

      class NotImplementedComponentError < Error; end

      class NamespaceAlreadyAddedError < Error; end

      class_attribute :lookup_namespaces, default: [ViewComponent::Form]

      class << self
        def inherited(base)
          base.lookup_namespaces = lookup_namespaces.dup

          super
        end

        def namespace(namespace)
          if lookup_namespaces.include?(namespace)
            raise NamespaceAlreadyAddedError, "The component namespace '#{namespace}' is already added"
          end

          lookup_namespaces.prepend namespace
        end
      end

      def initialize(*)
        @__component_klass_cache = {}

        super
      end

      (field_helpers - %i[
        check_box
        datetime_field
        datetime_local_field
        fields
        fields_for
        file_field
        hidden_field
        label
        phone_field
        radio_button
      ]).each do |selector|
        class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
          def #{selector}(method, options = {}) # def text_field(method, options = {})
            render_component(                   #   render_component(
              :#{selector},                     #     :text_field,
              @object_name,                     #     @object_name,
              method,                           #     method,
              objectify_options(options),       #     objectify_options(options),
            )                                   #   )
          end                                   # end
        RUBY_EVAL
      end
      alias phone_field telephone_field

      # See: https://github.com/rails/rails/blob/33d60cb02dcac26d037332410eabaeeb0bdc384c/actionview/lib/action_view/helpers/form_helper.rb#L2280
      def label(method, text = nil, options = {}, &block)
        render_component(:label, @object_name, method, text, objectify_options(options), &block)
      end

      def datetime_field(method, options = {})
        render_component(
          :datetime_local_field, @object_name, method, objectify_options(options)
        )
      end
      alias datetime_locale_field datetime_field

      def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
        render_component(
          :check_box, @object_name, method, checked_value, unchecked_value, objectify_options(options)
        )
      end

      def radio_button(method, tag_value, options = {})
        render_component(
          :radio_button, @object_name, method, tag_value, objectify_options(options)
        )
      end

      def file_field(method, options = {})
        self.multipart = true
        render_component(:file_field, @object_name, method, objectify_options(options))
      end

      def submit(value = nil, options = {})
        if value.is_a?(Hash)
          options = value
          value = nil
        end
        value ||= submit_default_value
        render_component(:submit, value, options)
      end

      def button(value = nil, options = {}, &block)
        if value.is_a?(Hash)
          options = value
          value = nil
        end
        value ||= submit_default_value
        render_component(:button, value, options, &block)
      end

      # See: https://github.com/rails/rails/blob/fe76a95b0d252a2d7c25e69498b720c96b243ea2/actionview/lib/action_view/helpers/form_options_helper.rb
      def select(method, choices = nil, options = {}, html_options = {}, &block)
        render_component(
          :select, @object_name, method, choices, objectify_options(options),
          @default_html_options.merge(html_options), &block
        )
      end

      # rubocop:disable Metrics/ParameterLists
      def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
        render_component(
          :collection_select, @object_name, method, collection, value_method, text_method,
          objectify_options(options), @default_html_options.merge(html_options)
        )
      end

      def grouped_collection_select(
        method, collection,
        group_method, group_label_method, option_key_method, option_value_method,
        options = {}, html_options = {}
      )
        render_component(
          :grouped_collection_select, @object_name, method, collection, group_method,
          group_label_method, option_key_method, option_value_method,
          objectify_options(options), @default_html_options.merge(html_options)
        )
      end

      def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
        render_component(
          :collection_check_boxes, @object_name, method, collection, value_method, text_method,
          objectify_options(options), @default_html_options.merge(html_options), &block
        )
      end

      def collection_radio_buttons(
        method, collection,
        value_method, text_method,
        options = {}, html_options = {},
        &block
      )
        render_component(
          :collection_radio_buttons, @object_name, method, collection, value_method, text_method,
          objectify_options(options), @default_html_options.merge(html_options), &block
        )
      end
      # rubocop:enable Metrics/ParameterLists

      def date_select(method, options = {}, html_options = {})
        render_component(
          :date_select, @object_name, method,
          objectify_options(options), @default_html_options.merge(html_options)
        )
      end

      def datetime_select(method, options = {}, html_options = {})
        render_component(
          :datetime_select, @object_name, method,
          objectify_options(options), @default_html_options.merge(html_options)
        )
      end

      def time_select(method, options = {}, html_options = {})
        render_component(
          :time_select, @object_name, method,
          objectify_options(options), @default_html_options.merge(html_options)
        )
      end

      def time_zone_select(method, priority_zones = nil, options = {}, html_options = {})
        render_component(
          :time_zone_select, @object_name, method, priority_zones,
          objectify_options(options), @default_html_options.merge(html_options)
        )
      end

      if defined?(ActionView::Helpers::Tags::ActionText)
        def rich_text_area(method, options = {})
          render_component(:rich_text_area, @object_name, method, objectify_options(options))
        end
      end

      def error_message(method, options = {})
        render_component(:error_message, @object_name, method, objectify_options(options))
      end

      def hint(method, text = nil, options = {}, &block)
        render_component(:hint, @object_name, method, text, objectify_options(options), &block)
      end

      private

      def render_component(component_name, *args, &block)
        component = component_klass(component_name).new(self, *args)
        component.render_in(@template, &block)
      end

      def objectify_options(options)
        @default_options.merge(options.merge(object: @object))
      end

      def component_klass(component_name)
        @__component_klass_cache[component_name] ||= begin
          component_klass = self.class.lookup_namespaces.filter_map do |namespace|
            "#{namespace}::#{component_name.to_s.camelize}Component".safe_constantize || false
          end.first

          unless component_klass.is_a?(Class) && component_klass < ViewComponent::Base
            raise NotImplementedComponentError, "Component named #{component_name} doesn't exist" \
                                                " or is not a ViewComponent::Base class"
          end

          component_klass
        end
      end
    end
  end
end
