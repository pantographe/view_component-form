# frozen_string_literal: true

RSpec.describe ViewComponent::Form::ErrorMessageComponent, type: :component do
  subject(:rendered_component) { render_inline(component) }

  let(:component) { described_class.new(form, object_name, :first_name, options) }

  let(:object_klass) do
    Class.new do
      include ActiveModel::Model

      attr_accessor :first_name

      validates :first_name, presence: true, length: { minimum: 2 }

      class << self
        def name
          "User"
        end
      end
    end
  end

  let(:object)  { object_klass.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:component_html_attributes) { rendered_component.css("div").first.attributes }

  context "with valid object" do
    subject { component }

    let(:object) { object_klass.new(first_name: "John") }

    before { object.validate }

    it { is_expected.to have_attributes(method_errors: [], render?: false) }
  end

  context "with invalid object" do
    let(:object) { object_klass.new(first_name: "") }

    before { object.validate }

    context "with simple args" do
      it { expect(component.method_errors).to eq(["Can't be blank", "Is too short (minimum is 2 characters)"]) }
      it { expect(component.render?).to be true }

      it { is_expected.to eq_html "<div>Can't be blank<br>Is too short (minimum is 2 characters)</div>" }
    end

    include_examples "component with custom html classes"
    include_examples "component with custom data attributes"
  end
end
