# frozen_string_literal: true

RSpec.describe ViewComponent::Form::CheckBoxComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :admin, "1", "0", options)) }
  let(:component_html_attributes) { component.css("input").last.attributes }

  context "with simple args" do
    it do
      expect(component.to_html).to eq(
        %(<input name="user[admin]" type="hidden" value="0">) +
          %(<input type="checkbox" value="1" name="user[admin]" id="user_admin">)
      )
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
end
