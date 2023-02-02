# frozen_string_literal: true

RSpec.shared_examples "component with custom value" do |value: "Hello World"|
  context "with custom value" do
    let(:options) { { value: value } }

    it { expect(component_html_attributes["value"].to_s).to include(value) }
  end
end
