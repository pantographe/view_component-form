# frozen_string_literal: true

RSpec.describe ViewComponent::Form::TextAreaComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :bio, options)) }
  let(:component_html_attributes) { component.css("textarea").first.attributes }

  context "with simple args" do
    it do
      expect(component).to eq_html <<~HTML
        <textarea name="user[bio]" id="user_bio">
        </textarea>
      HTML
    end
  end

  context "with custom value" do
    let(:options) { { value: "Hello World" } }

    it { expect(component.css("textarea").first.content).to include("Hello World") }
  end

  it_behaves_like "component with custom html classes"
  it_behaves_like "component with custom data attributes"
end
