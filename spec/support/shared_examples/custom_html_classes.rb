# frozen_string_literal: true

RSpec.shared_examples "component with custom html classes" do |options_keyword_arg_name = :options|
  context "with custom html classes" do
    let(options_keyword_arg_name) { { class: "custom-css-class" } }

    it { expect(component_html_attributes["class"].to_s).to include("custom-css-class") }
  end
end
