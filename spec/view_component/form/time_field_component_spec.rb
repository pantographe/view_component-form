# frozen_string_literal: true

RSpec.describe ViewComponent::Form::TimeFieldComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(model: object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, :user, :alarm_clock, options)) }
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

  if Gem::Version.new(Rails::VERSION::STRING) < Gem::Version.new("7.1.0.alpha")
    include_examples "component with custom value"
  else
    context "with custom value" do
      let(:options) { { value: DateTime.new(2004, 6, 15, 1, 2, 3) } }

      it { expect(component_html_attributes["value"].to_s).to eq("01:02:03.000") }
    end
  end
end
