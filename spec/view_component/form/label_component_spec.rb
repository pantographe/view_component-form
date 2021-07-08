# frozen_string_literal: true

RSpec.describe ViewComponent::Form::LabelComponent, type: :component do
  let(:object)  { OpenStruct.new(errors: []) }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:block)   { nil }

  let(:component) { render_inline(described_class.new(form, object_name, :first_name, options), &block) }
  let(:component_html_attributes) { component.css("label").first.attributes }

  context "with simple args" do
    it do
      expect(component.to_html).to eq_html <<~HTML
        <label for="user_first_name">First name</label>
      HTML
    end
  end

  context "with content and options" do
    let(:options) { { class: "custom-label" } }
    let(:component) { render_inline(described_class.new(form, object_name, :first_name, "Your first name", options)) }

    it do
      expect(component.to_html).to eq_html <<~HTML
        <label class="custom-label" for="user_first_name">Your first name</label>
      HTML
    end
  end

  context "with a block" do
    let(:block) do
      proc do
        "Your <strong>first name</strong>".html_safe
      end
    end

    it do
      expect(component.to_html).to eq_html <<~HTML
        <label for="user_first_name">Your <strong>first name</strong></label>
      HTML
    end
  end

  context "with a block and translation param" do
    let(:block) do
      proc do |component|
        "<span class=\"translated-label\">#{component.translation}</span>".html_safe
      end
    end

    it do
      expect(component.to_html).to eq(
        %(<label for="user_first_name"><span class="translated-label">First name</span></label>)
      )
    end
  end

  context "with a block and builder param" do
    let(:block) do
      proc do |component|
        "<span class=\"translated-label#{" has-error" if component.builder.object.errors.include?(:first_name)}\">" \
        "#{component.builder.translation}</span>".html_safe
      end
    end

    it do
      expect(component.to_html).to eq(
        %(<label for="user_first_name"><span class="translated-label">First name</span></label>)
      )
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
end
