# frozen_string_literal: true

RSpec.describe ViewComponent::Form::CheckBoxComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(model: object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, :user, :admin, "1", "0", options)) }
  let(:component_html_attributes) { component.css("input").last.attributes }

  context "with simple args" do
    it { expect(component.to_html).to have_tag("input", with: { type: "hidden", value: "0", name: "user[admin]" }) }

    it do
      expect(component.to_html)
        .to have_tag("input", with: { type: "checkbox", value: "1", name: "user[admin]", id: "user_admin" })
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
end
