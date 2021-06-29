# frozen_string_literal: true

RSpec.shared_examples "component with custom html classes" do
  context "with custom html classes" do
    let(:options) { { class: "custom-css-class" } }

    it { expect(component_html_attributes["class"].to_s).to include("custom-css-class") }
  end
end
