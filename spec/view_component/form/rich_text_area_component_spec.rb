# frozen_string_literal: true

RSpec.describe ViewComponent::Form::RichTextAreaComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :bio, options)) }
  let(:component_html_attributes) { component.css("textarea").first.attributes }

  context "with simple args" do
    it do
      expect(component.to_html).to eq(
        %(<textarea name="user[bio]" id="user_bio">\n</textarea>)
      )
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
end
