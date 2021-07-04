# frozen_string_literal: true

RSpec.describe ViewComponent::Form::TimeZoneSelectComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:html_options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :time_zone, nil, options, html_options)) }
  let(:component_html_attributes) { component.css("select").first.attributes }

  context "with simple args" do
    it do
      expect(component.to_html).to start_with(
        %(<select name="user[time_zone]" id="user_time_zone">)
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
