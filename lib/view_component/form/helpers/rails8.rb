# frozen_string_literal: true

module ViewComponent
  module Form
    module Helpers
      # Rails 8.0 changed the spelling of a couple form builder methods while adding aliases
      # for backward compatibility. This module adds those new methods, rendering through the original ones, so that
      # a builder overriding an original spelling (e.g. `check_box`) changes the new one too.
      #
      # https://github.com/rails/rails/blob/8-0-stable/actionview/CHANGELOG.md#rails-800beta1-september-26-2024
      module Rails8
        def textarea(method, options = {})
          text_area(method, options)
        end

        def checkbox(method, options = {}, checked_value = "1", unchecked_value = "0")
          check_box(method, options, checked_value, unchecked_value)
        end

        def collection_checkboxes(method, collection, value_method, text_method, options = {}, html_options = {}, # rubocop:disable Metrics/ParameterLists
                                  &)
          render_component(
            :collection_check_boxes, @object_name, method, collection, value_method, text_method,
            objectify_options(options), @default_html_options.merge(html_options), &
          )
        end

        if defined?(ActionView::Helpers::Tags::ActionText)
          def rich_textarea(method, options = {}, &)
            rich_text_area(method, options, &)
          end
        end
      end
    end
  end
end
