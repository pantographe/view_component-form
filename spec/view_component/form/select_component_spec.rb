# frozen_string_literal: true

RSpec.describe ViewComponent::Form::SelectComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:html_options) { {} }

  let(:component) do
    render_inline(described_class.new(
                    form,
                    object_name,
                    :role,
                    [["Admin", :admin], ["Manager", :manager]],
                    options,
                    html_options
                  ))
  end
  let(:component_html_attributes) { component.css("select").first.attributes }

  context "with simple args" do
    it do
      expect(component.to_html).to eq(
        "<select name=\"user[role]\" id=\"user_role\"><option value=\"admin\">Admin</option>\n" \
        "<option value=\"manager\">Manager</option></select>"
      )
    end
  end

  context "with selected value" do
    let(:options) { { selected: "manager" } }

    it do
      expect(component.to_html).to eq(
        "<select name=\"user[role]\" id=\"user_role\"><option value=\"admin\">Admin</option>\n" \
        "<option selected value=\"manager\">Manager</option></select>"
      )
    end
  end

  context "with multiple select" do
    let(:html_options) { { multiple: true } }

    it do # rubocop:disable RSpec/ExampleLength
      expect(component.to_html).to eq(
        "<input name=\"user[role][]\" type=\"hidden\" value=\"\">" \
        "<select multiple name=\"user[role][]\" id=\"user_role\">" \
        "<option value=\"admin\">Admin</option>\n" \
        "<option value=\"manager\">Manager</option></select>"
      )
    end
  end

  include_examples "component with custom html classes", :html_options
  include_examples "component with custom data attributes", :html_options
end
