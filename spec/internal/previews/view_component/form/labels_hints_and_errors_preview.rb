# frozen_string_literal: true

module ViewComponent
  module Form
    # @label Labels, hints and errors
    class LabelsHintsAndErrorsPreview < ApplicationPreview
      def label
        form { |f| f.label :name }
      end

      def label_with_text
        form { |f| f.label :name, "Full name" }
      end

      def hint
        form { |f| f.hint :password, "At least 8 characters" }
      end

      def error_message
        form(User.invalid) { |f| f.error_message :age }
      end

      # A label, a field, its hint and its errors, the field described by the hint and the errors through their ids
      def field_with_label_hint_and_errors
        form(User.invalid) do |f|
          f.label(:age) +
            f.number_field(:age, aria: { describedby: [f.field_id(:age, :hint), f.field_id(:age, :error)].join(" ") }) +
            f.hint(:age, "You must be 18 or older") +
            f.error_message(:age)
        end
      end
    end
  end
end
