# frozen_string_literal: true

RSpec.describe ViewComponent::Form::TimeFieldComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :alarm_clock, options)) }
  let(:component_html_attributes) { component.css("input").first.attributes }

  context "with simple args" do
    it do
      expect(component).to eq_html <<~HTML
        <input type="time" name="user[alarm_clock]" id="user_alarm_clock">
      HTML
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
  include_examples "component with custom value"
end
