# frozen_string_literal: true

RSpec.describe ViewComponent::Form::FileFieldComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :avatar, options)) }
  let(:component_html_attributes) { component.css("input").first.attributes }

  context "with simple args" do
    it do
      expect(component.to_html).to eq(
        %(<input type="file" name="user[avatar]" id="user_avatar">)
      )
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
end
