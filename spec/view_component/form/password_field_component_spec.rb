# frozen_string_literal: true

RSpec.describe ViewComponent::Form::PasswordFieldComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :password, options)) }
  let(:component_html_attributes) { component.css("input").first.attributes }

  context "with simple args" do
    it do
      expect(component).to eq_html <<~HTML
        <input type="password" name="user[password]" id="user_password">
      HTML
    end
  end

  it_behaves_like "component with custom html classes"
  it_behaves_like "component with custom data attributes"
  it_behaves_like "component with custom value"
end
