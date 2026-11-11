# frozen_string_literal: true

RSpec.describe ViewComponent::Form::CountrySelectComponent, type: :component do
  let(:object)  { Object.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:html_options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :country, options, html_options)) }
  let(:component_html_attributes) { component.css("select").first.attributes }

  context "with simple args" do
    it "has a select of countries" do
      expect(component.to_html).to have_tag("select", with: { id: "user_country", name: "user[country]" }) do
        with_tag "option", with: { value: "FR" }, text: "France"
        with_tag "option", with: { value: "BE" }, text: "Belgium"
      end
    end
  end

  context "with selected value" do
    let(:options) { { selected: "FR" } }

    it { expect(component.to_html).to have_tag("option", with: { value: "FR", selected: "selected" }) }
  end

  context "with country_select's options" do
    let(:options) { { only: %w[BE FR] } }

    it "passes them on" do
      expect(component.css("option").map { |option| option["value"] }).to eq(%w[BE FR])
    end
  end

  it_behaves_like "component with custom html classes", :html_options
  it_behaves_like "component with custom data attributes", :html_options
end
