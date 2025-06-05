# frozen_string_literal: true

RSpec.describe ViewComponent::Form::DateSelectComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:html_options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :birth_date, options, html_options)) }
  let(:component_html_attributes) { component.css("select").first.attributes }

  context "with simple args" do
    it "has a select for the year" do
      expect(component.to_html).to have_tag("select", with: { id: "user_birth_date_1i", name: "user[birth_date(1i)]" })
    end

    it "has a select for the month" do
      expect(component.to_html).to have_tag("select", with: { id: "user_birth_date_2i", name: "user[birth_date(2i)]" })
    end

    it "has a select for the day" do
      expect(component.to_html).to have_tag("select", with: { id: "user_birth_date_3i", name: "user[birth_date(3i)]" })
    end
  end

  it_behaves_like "component with custom html classes", :html_options
  it_behaves_like "component with custom data attributes", :html_options
end
