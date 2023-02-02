# frozen_string_literal: true

RSpec.describe ViewComponent::Form::DateFieldComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :birth_date, options)) }
  let(:component_html_attributes) { component.css("input").first.attributes }

  context "with simple args" do
    it do
      expect(component).to eq_html <<~HTML
        <input type="date" name="user[birth_date]" id="user_birth_date">
      HTML
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"

  if Gem::Version.new(Rails::VERSION::STRING) < Gem::Version.new("7.1.0.alpha")
    include_examples "component with custom value"
  else
    context "with custom value" do
      let(:options) { { value: DateTime.new(2013, 6, 29) } }

      it { expect(component_html_attributes["value"].to_s).to eq("2013-06-29") }
    end
  end
end
