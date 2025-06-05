# frozen_string_literal: true

module ViewComponent
  module Form
    module Helpers
      # Rails 8.0 changed the spelling of a couple form builder methods while adding aliases
      # for backward compatibility. This module adds those new methods.
      #
      # https://github.com/rails/rails/blob/8-0-stable/actionview/CHANGELOG.md#rails-800beta1-september-26-2024
      module Rails8
        def textarea(method, options = {})
          render_component(:text_area, @object_name, method, objectify_options(options))
        end

        def checkbox(method, options = {}, checked_value = "1", unchecked_value = "0")
          render_component(:check_box, @object_name, method, checked_value, unchecked_value, objectify_options(options))
        end

        def collection_checkboxes(method, collection, value_method, text_method, options = {}, html_options = {}, # rubocop:disable Metrics/ParameterLists
                                  &)
          render_component(
            :collection_check_boxes, @object_name, method, collection, value_method, text_method,
            objectify_options(options), @default_html_options.merge(html_options), &
          )
        end

        if defined?(ActionView::Helpers::Tags::ActionText)
          def rich_textarea(method, options = {})
            render_component(:rich_text_area, @object_name, method, objectify_options(options))
          end
        end
      end
    end
  end
end
