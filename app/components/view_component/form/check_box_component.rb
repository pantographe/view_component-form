# frozen_string_literal: true

module ViewComponent
  module Form
    class CheckBoxComponent < FieldComponent
      attr_reader :checked_value, :unchecked_value

      def initialize(form, object_name, method_name, checked_value, unchecked_value, options = {}) # rubocop:disable Metrics/ParameterLists
        @checked_value   = checked_value
        @unchecked_value = unchecked_value

        super(form, object_name, method_name, options)
      end

      def call # rubocop:disable Metrics/AbcSize
        if options[:label] == false
          ActionView::Helpers::Tags::CheckBox.new(
            object_name,
            method_name,
            form,
            checked_value,
            unchecked_value,
            options
          ).render
        else
          render(ViewComponent::Form::LabelComponent.new(form, object_name, method_name)) do
            concat ActionView::Helpers::Tags::CheckBox.new(
              object_name,
              method_name,
              form,
              checked_value,
              unchecked_value,
              options
            ).render
            concat tag.span(check_box_text)
          end
        end
      end

      def check_box_text
        @check_box_text ||= ActionView::Helpers::Tags::Translator.new(
          object, object_name, method_name, scope: "helpers.checkbox"
        ).translate
      end
    end
  end
end
