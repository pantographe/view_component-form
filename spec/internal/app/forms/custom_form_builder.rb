# frozen_string_literal: true

class CustomFormBuilder < ViewComponent::Form::Builder
  namespace Form

  def badge(method, label:, **options)
    render_component(:badge, @object_name, method, label:, **objectify_options(options))
  end
end
