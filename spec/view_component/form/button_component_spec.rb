# frozen_string_literal: true

RSpec.describe ViewComponent::Form::ButtonComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:value) { "Send" }

  let(:component) { render_inline(described_class.new(form, value, options)) }
  let(:component_html_attributes) { component.css("button").first.attributes }

  context "with simple args" do
    it do
      expect(component.to_html).to eq(
        %(<button name="button" type="submit">Send</button>)
      )
    end
  end

  context "with a block" do
    let(:component) do
      render_inline(
        described_class.new(form, value, options) { "Send <strong>now</strong>!" }
      )
    end

    it do
      expect(component.to_html).to eq(
        %(<button name="button" type="submit">Send <strong>now</strong>!</button>)
      )
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
end
