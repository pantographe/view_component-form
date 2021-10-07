# frozen_string_literal: true

RSpec.describe ViewComponent::Form::NumberFieldComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :shoe_size, options)) }
  let(:component_html_attributes) { component.css("input").first.attributes }

  context "with simple args" do
    it do
      expect(component).to eq_html <<~HTML
        <input type="number" name="user[shoe_size]" id="user_shoe_size">
      HTML
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
  include_examples "component with custom value"
end
