# frozen_string_literal: true

RSpec.describe ViewComponent::Form::TimeSelectComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:html_options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :wakes_up_at, options, html_options)) }
  let(:component_html_attributes) { component.css("select").first.attributes }

  context "with simple args" do
    it do
      expect(component.to_html).to include(
        %(<select id="user_wakes_up_at_4i" name="user[wakes_up_at(4i)]">)
      )
    end
  end

  context "with custom html classes" do
    let(:html_options) { { class: "custom-css-class" } }

    it { expect(component_html_attributes["class"].to_s).to include("custom-css-class") }
  end

  context "with custom data attributes" do
    let(:html_options) { { data: { key: "value" } } }

    it { expect(component_html_attributes["data-key"].to_s).to include("value") }
  end
end
