# frozen_string_literal: true

module ViewComponent
  module Form
    # :nodoc:
    class Engine < ::Rails::Engine
      config.autoload_once_paths = %W[
        #{root}/app/components
        #{root}/app/components/concerns
        #{root}/app/lib
      ]
    end
  end
end
