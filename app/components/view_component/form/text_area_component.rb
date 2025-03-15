# frozen_string_literal: true

if Gem::Version.new(Rails::VERSION::STRING) < Gem::Version.new("8.0")
  module ViewComponent
    module Form
      class TextAreaComponent < TextareaComponent
      end
    end
  end
end
