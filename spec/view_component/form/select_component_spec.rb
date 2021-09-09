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
      expect(component).to eq_html <<~HTML
        <select name="user[role]" id="user_role"><option value="admin">Admin</option>
        <option value="manager">Manager</option></select>
      HTML
    end
  end

  context "with selected value" do
    let(:options) { { selected: "manager" } }

    it do
      expect(component).to eq_html <<~HTML
        <select name="user[role]" id="user_role"><option value="admin">Admin</option>
        <option selected value="manager">Manager</option></select>
      HTML
    end
  end

  context "with multiple select" do
    let(:html_options) { { multiple: true } }

    it do
      expect(component).to eq_html <<~HTML
        <input name="user[role][]" type="hidden" value=""><select multiple name="user[role][]" id="user_role"><option value="admin">Admin</option>
        <option value="manager">Manager</option></select>
      HTML
    end
  end

  include_examples "component with custom html classes", :html_options
  include_examples "component with custom data attributes", :html_options
end
