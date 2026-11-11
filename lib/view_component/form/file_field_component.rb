# frozen_string_literal: true

module ViewComponent
  module Form
    class FileFieldComponent < FieldComponent
      self.tag_klass = ActionView::Helpers::Tags::FileField

      def before_render
        @options = { include_hidden: multiple_file_field_include_hidden }.merge!(options)
        @options = convert_direct_upload_option_to_url(@options.dup)

        super
      end
    end
  end
end
