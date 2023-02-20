# frozen_string_literal: true

RSpec.describe ViewComponent::Form::SubmitComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(model: object) }
  let(:options) { {} }
  let(:value)   { "" }

  let(:component) { render_inline(described_class.new(form, value, options)) }
  let(:component_html_attributes) { component.css("input").first.attributes }

  context "with simple args" do
    it do
      expect(component).to eq_html <<~HTML
        <input type="submit" name="commit" value="" data-disable-with="">
      HTML
    end
  end

  context "with value" do
    let(:value) { "Save" }

    it do
      expect(component).to eq_html <<~HTML
        <input type="submit" name="commit" value="Save" data-disable-with="Save">
      HTML
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
  include_examples "component with custom value"
end
