# frozen_string_literal: true

Rails.application.configure do
  config.view_component.preview_paths << Rails.root.join("test/components/previews")

  config.view_component.default_preview_layout = "component_preview"
end
