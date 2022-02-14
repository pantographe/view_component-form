# frozen_string_literal: true

RSpec.describe ViewComponent::Form::HintComponent, type: :component do
  subject(:rendered_component) { render_inline(component) }

  let(:component) { described_class.new(form, object_name, :birth_date, "this is my hint for you", options) }
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:component_html_attributes) { rendered_component.css("div").first.attributes }

  context "with simple args" do
    it { is_expected.to eq_html "<div>this is my hint for you</div>" }
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
  include_examples "component with custom value"
end
