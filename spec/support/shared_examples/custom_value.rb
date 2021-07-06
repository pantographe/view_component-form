# frozen_string_literal: true

RSpec.shared_examples "component with custom value" do
  context "with custom value" do
    let(:options) { { value: "Hello World" } }

    it { expect(component_html_attributes["value"].to_s).to include("Hello World") }
  end
end
