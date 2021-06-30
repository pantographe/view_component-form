# frozen_string_literal: true

RSpec.describe ViewComponent::Form::SelectComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:html_options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :role, [["Admin", :admin], ["Manager", :manager]], options, html_options)) }
  let(:component_html_attributes) { component.css("select").first.attributes }

  context "with simple args" do
    it do
      expect(component.to_html).to eq(
        %(<select name="user[role]" id="user_role">) +
          %(<option value="admin">Admin</option>\n) +
          %(<option value="manager">Manager</option>) +
        %(</select>)
      )
    end
  end

  context "with custom html classes" do
    let(:html_options) { { class: "custom-css-class" } }

    it { expect(component_html_attributes["class"].to_s).to include("custom-css-class") }
  end

  context "with custom data attributes" do
    let(:html_options) { { data: { key: "value" } } }

    it { expect(component_html_attributes["data-key"].to_s).to include("value") }
  end
end
