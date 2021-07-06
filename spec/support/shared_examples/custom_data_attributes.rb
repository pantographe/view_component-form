# frozen_string_literal: true

RSpec.shared_examples "component with custom data attributes" do |options_keyword_arg_name = :options|
  context "with custom data attributes" do
    let(options_keyword_arg_name) { { data: { key: "value" } } }

    it { expect(component_html_attributes["data-key"].to_s).to include("value") }
  end
end
