# frozen_string_literal: true

module ViewComponent
  module Form
    module Helpers
      module Custom
        def error_message(method, options = {})
          render_component(:error_message, @object_name, method, objectify_options(options))
        end

        def hint(method, text = nil, options = {}, &)
          render_component(:hint, @object_name, method, text, objectify_options(options), &)
        end

        # With the country_select gem (https://github.com/countries/country_select), loaded before this module (as
        # Bundler does, requiring the app's gems before the builder is first used)
        if defined?(ActionView::Helpers::Tags::CountrySelect)
          def country_select(method, options = {}, html_options = {})
            render_component(
              :country_select, @object_name, method,
              objectify_options(options), @default_html_options.merge(html_options)
            )
          end
        end
      end
    end
  end
end
