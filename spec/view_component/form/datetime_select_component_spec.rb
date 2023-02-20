# frozen_string_literal: true

RSpec.describe ViewComponent::Form::DatetimeSelectComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(model: object) }
  let(:options) { {} }
  let(:html_options) { {} }

  let(:component) { render_inline(described_class.new(form, :user, :created_at, options, html_options)) }
  let(:component_html_attributes) { component.css("select").first.attributes }

  context "with simple args" do
    it "has a select for the year" do
      expect(component.to_html).to have_tag("select", with: { id: "user_created_at_1i", name: "user[created_at(1i)]" })
    end

    it "has a select for the month" do
      expect(component.to_html).to have_tag("select", with: { id: "user_created_at_2i", name: "user[created_at(2i)]" })
    end

    it "has a select for the day" do
      expect(component.to_html).to have_tag("select", with: { id: "user_created_at_3i", name: "user[created_at(3i)]" })
    end

    it "has a select for the hours" do
      expect(component.to_html).to have_tag("select", with: { id: "user_created_at_4i", name: "user[created_at(4i)]" })
    end

    it "has a select for the minutes" do
      expect(component.to_html).to have_tag("select", with: { id: "user_created_at_5i", name: "user[created_at(5i)]" })
    end
  end

  include_examples "component with custom html classes", :html_options
  include_examples "component with custom data attributes", :html_options
end
