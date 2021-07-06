# frozen_string_literal: true

# Backport of https://api.rubyonrails.org/classes/ActionView/Helpers/TagHelper.html#method-i-class_names
module ViewComponent
  module Form
    module ClassNamesHelper
      # rubocop:disable Metrics/CyclomaticComplexity
      # rubocop:disable Metrics/MethodLength
      def build_tag_values(*args)
        tag_values = []

        args.each do |tag_value|
          case tag_value
          when Hash
            tag_value.each do |key, val|
              tag_values << key.to_s if val && key.present?
            end
          when Array
            tag_values.concat build_tag_values(*tag_value)
          else
            tag_values << tag_value.to_s if tag_value.present?
          end
        end

        tag_values
      end
      # rubocop:enable Metrics/CyclomaticComplexity
      # rubocop:enable Metrics/MethodLength

      def class_names(*args)
        tokens = build_tag_values(*args).flat_map { |value| value.to_s.split(/\s+/) }.uniq

        safe_join(tokens, " ")
      end
    end
  end
end
