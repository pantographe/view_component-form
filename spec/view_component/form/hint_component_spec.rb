# frozen_string_literal: true

RSpec.describe ViewComponent::Form::HintComponent, type: :component do
  subject(:rendered_component) { render_inline(component) }

  let(:component) { described_class.new(form, object_name, :birth_date, "this is my hint for you", options) }
  let(:object)  { Object.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:component_html_attributes) { rendered_component.css("div").first.attributes }

  context "with simple args" do
    it { is_expected.to eq_html '<div id="user_birth_date_hint">this is my hint for you</div>' }
  end

  context "with an id" do
    let(:options) { { id: "birth_date_help" } }

    it { expect(component_html_attributes["id"].value).to eq("birth_date_help") }
  end

  context "with an id as a string key" do
    let(:options) { { "id" => "birth_date_help" } }

    it { is_expected.to eq_html '<div id="birth_date_help">this is my hint for you</div>' }
  end

  context "with the builder's skip_default_ids" do
    let(:options) { { skip_default_ids: true } }

    it { expect(component_html_attributes).not_to have_key("id") }
  end

  it_behaves_like "component with custom html classes"
  it_behaves_like "component with custom data attributes"
  it_behaves_like "component with custom value"
end
