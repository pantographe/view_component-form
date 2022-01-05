# frozen_string_literal: true

RSpec.describe ViewComponent::Form::HintComponent, type: :component do
  subject { described_class.new(form, object_name, :birth_date, "this is my hint for you", options) }

  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  let(:component) { render_inline(subject) }
  let(:component_html_attributes) { component.css("div").first.attributes }

  context "with simple args" do
    it do
      expect(component).to eq_html <<~HTML
        <div>this is my hint for you</div>
      HTML
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
  include_examples "component with custom value"
end
