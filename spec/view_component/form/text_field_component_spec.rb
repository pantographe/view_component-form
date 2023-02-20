# frozen_string_literal: true

RSpec.describe ViewComponent::Form::TextFieldComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(model: object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, :user, :email, options)) }
  let(:component_html_attributes) { component.css("input").first.attributes }

  context "with simple args" do
    it do
      expect(component).to eq_html <<~HTML
        <input type="text" name="user[email]" id="user_email">
      HTML
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
  include_examples "component with custom value"
end
