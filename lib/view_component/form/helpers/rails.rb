# frozen_string_literal: true

module ViewComponent
  module Form
    module Helpers
      # rubocop:disable Metrics/ModuleLength
      module Rails
        # rubocop:disable Metrics/MethodLength
        def self.included(base)
          base.class_eval do
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
              textarea
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
            alias_method :phone_field, :telephone_field
          end
        end
        # rubocop:enable Metrics/MethodLength

        # See: https://github.com/rails/rails/blob/33d60cb02dcac26d037332410eabaeeb0bdc384c/actionview/lib/action_view/helpers/form_helper.rb#L2280
        def label(method, text = nil, options = {}, &block)
          render_component(:label, @object_name, method, text, objectify_options(options), &block)
        end

        def datetime_field(method, options = {})
          render_component(
            :datetime_local_field, @object_name, method, objectify_options(options)
          )
        end
        alias datetime_local_field datetime_field

        def textarea(method, options = {})
          render_component(
            :text_area, @object_name, method, objectify_options(options)
          )
        end
        alias text_area textarea

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

        def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {},
                                   &block)
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
      end
      # rubocop:enable Metrics/ModuleLength
    end
  end
end
