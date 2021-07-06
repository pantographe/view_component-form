# frozen_string_literal: true

require "action_view"

module ViewComponent
  module Form
    class Builder < ActionView::Helpers::FormBuilder
      include ActionView::Helpers::FormTagHelper

      class Error < StandardError; end

      class NotImplementedComponentError < Error; end

      class << self
        attr_accessor :components_namespace
      end

      self.components_namespace = "ViewComponent::Form"

      (field_helpers - %i[label check_box radio_button fields_for fields hidden_field file_field]).each do |selector|
        class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
          def #{selector}(method, options = {}) # def text_field(method, options = {})
            render_component(                   #   render_component(
              :#{selector},                     #     :text_field,
              self,                             #     self,
              @object_name,                     #     @object_name,
              method,                           #     method,
              objectify_options(options),       #     objectify_options(options),
            )                                   #   )
          end                                   # end
        RUBY_EVAL
      end

      # See: https://github.com/rails/rails/blob/33d60cb02dcac26d037332410eabaeeb0bdc384c/actionview/lib/action_view/helpers/form_helper.rb#L2280
      def label(method, text = nil, options = {}, &block)
        render_component(:label, self, @object_name, method, text, objectify_options(options), &block)
      end

      def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
        render_component(
          :check_box, self, @object_name, method, checked_value, unchecked_value, objectify_options(options)
        )
      end

      def radio_button(method, tag_value, options = {})
        render_component(
          :radio_button, self, @object_name, method, tag_value, objectify_options(options)
        )
      end

      def file_field(method, options = {})
        self.multipart = true
        render_component(:file_field, self, @object_name, method, objectify_options(options))
      end

      def submit(value = nil, options = {})
        if value.is_a?(Hash)
          options = value
          value = nil
        end
        value ||= submit_default_value
        render_component(:submit, self, value, options)
      end

      def button(value = nil, options = {}, &block)
        if value.is_a?(Hash)
          options = value
          value = nil
        end
        value ||= submit_default_value
        render_component(:button, self, value, options, &block)
      end

      # SELECTORS.each do |selector|
      #   class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      #     def #{selector}(*args)
      #       render_component(
      #         :#{selector},
      #         *args,
      #         super,
      #       )
      #     end
      #   RUBY_EVAL
      # end

      # See: https://github.com/rails/rails/blob/fe76a95b0d252a2d7c25e69498b720c96b243ea2/actionview/lib/action_view/helpers/form_options_helper.rb
      def select(method, choices = nil, options = {}, html_options = {}, &block)
        render_component(
          :select, self, @object_name, method, choices, objectify_options(options),
          @default_html_options.merge(html_options), &block
        )
      end

      # rubocop:disable Metrics/ParameterLists
      def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
        render_component(
          :collection_select, self, @object_name, method, collection, value_method, text_method,
          objectify_options(options), @default_html_options.merge(html_options)
        )
      end

      def grouped_collection_select(
        method, collection,
        group_method, group_label_method, option_key_method, option_value_method,
        options = {}, html_options = {}
      )
        render_component(
          :grouped_collection_select, self, @object_name, method, collection, group_method,
          group_label_method, option_key_method, option_value_method,
          objectify_options(options), @default_html_options.merge(html_options)
        )
      end

      def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {}, &block)
        render_component(
          :collection_check_boxes, self, @object_name, method, collection, value_method, text_method,
          objectify_options(options), @default_html_options.merge(html_options), &block
        )
      end
      # rubocop:enable Metrics/ParameterLists

      def date_select(method, options = {}, html_options = {})
        render_component(
          :date_select, self, @object_name, method,
          objectify_options(options), @default_html_options.merge(html_options)
        )
      end

      def datetime_select(method, options = {}, html_options = {})
        render_component(
          :datetime_select, self, @object_name, method,
          objectify_options(options), @default_html_options.merge(html_options)
        )
      end

      def time_select(method, options = {}, html_options = {})
        render_component(
          :time_select, self, @object_name, method,
          objectify_options(options), @default_html_options.merge(html_options)
        )
      end

      def time_zone_select(method, options = {}, html_options = {})
        render_component(
          :time_zone_select, self, @object_name, method,
          objectify_options(options), @default_html_options.merge(html_options)
        )
      end

      private

      def render_component(component_name, *args, &block)
        component_klassname = "#{self.class.components_namespace}::#{component_name.to_s.camelize}Component"
        component_klass     = component_klassname.safe_constantize

        unless component_klass.is_a?(Class) && component_klass < ViewComponent::Base
          raise NotImplementedComponentError, "Component #{component_klassname} doesn't exist" \
                                              " or is not a ViewComponent::Base class"
        end

        component = component_klass.new(*args)
        component.render_in(@template, &block)
      end

      def objectify_options(options)
        @default_options.merge(options.merge(object: @object))
      end
    end
  end
end
