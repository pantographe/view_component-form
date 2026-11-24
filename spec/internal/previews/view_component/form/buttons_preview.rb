# frozen_string_literal: true

module ViewComponent
  module Form
    # @label Buttons
    class ButtonsPreview < ApplicationPreview
      def submit
        form(&:submit)
      end

      def submit_with_text
        form { |f| f.submit "Sign up" }
      end

      def button
        form { |f| f.button "Save draft", name: "draft" }
      end
    end
  end
end
