# frozen_string_literal: true

RSpec.describe ViewComponent::Form::RadioButtonComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(model: object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, :user, :civility, "mrs", options)) }
  let(:component_html_attributes) { component.css("input").first.attributes }

  context "with simple args" do
    it do
      expect(component).to eq_html <<~HTML
        <input type="radio" value="mrs" name="user[civility]" id="user_civility_mrs">
      HTML
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
end
