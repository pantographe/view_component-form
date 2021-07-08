# frozen_string_literal: true

RSpec.describe ViewComponent::Form::DatetimeSelectComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:html_options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :created_at, options, html_options)) }
  let(:component_html_attributes) { component.css("select").first.attributes }

  context "with simple args" do
    it do
      expect(component.to_html).to start_with(
        %(<select id="user_created_at_1i" name="user[created_at(1i)]">)
      )
    end
  end

  include_examples "component with custom html classes", :html_options
  include_examples "component with custom data attributes", :html_options
end
