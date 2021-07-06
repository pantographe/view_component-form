# frozen_string_literal: true

RSpec.describe ViewComponent::Form::ButtonComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:value)   { "Send" }
  let(:block)   { nil }

  let(:component) { render_inline(described_class.new(form, value, options), &block) }
  let(:component_html_attributes) { component.css("button").first.attributes }

  context "with simple args" do
    it do
      expect(component.to_html).to eq(
        %(<button name="button" type="submit">Send</button>)
      )
    end
  end

  context "with a block" do
    let(:block) do
      proc do
        "Send <strong>now</strong>!".html_safe
      end
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
