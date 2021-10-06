module ViewComponent
  module FormTagHelper
    def text_field_tag(name, value = nil, builder: nil, **options)
      return super if builder.blank?

      builder.mapping.text_field_tag(nil, name, value: value, **options)
    end

    def label_tag(name = nil, content_or_options = nil, builder: nil, **options, &block)
      original_tag = super
      return original_tag if builder.blank?
      return content_tag :label, content_or_options || name.to_s.humanize, options, &block if builder.blank?

      builder.mapping.label_tag(nil, content_or_options || name.to_s.humanize, **options)
    end

    def password_field_tag(name = "password", value = nil, builder: nil, **options)
      return super if builder.blank?

      builder.mapping.password_field_tag(nil, name, value: value, **options)
    end
  end
end
