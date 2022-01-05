# frozen_string_literal: true

RSpec.describe ViewComponent::Form::ErrorMessageComponent, type: :component do
  subject { described_class.new(form, object_name, :first_name, options) }

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

  let(:component) { render_inline(subject) }
  let(:component_html_attributes) { component.css("div").first.attributes }

  context "with valid object" do
    let(:object) { object_klass.new(first_name: "John") }

    before { object.validate }

    it { expect(subject.method_errors).to eq([]) }
    it { expect(subject.render?).to be false }
  end

  context "with invalid object" do
    let(:object) { object_klass.new(first_name: "") }

    before { object.validate }

    context "with simple args" do
      it { expect(subject.method_errors).to eq(["Can't be blank", "Is too short (minimum is 2 characters)"]) }
      it { expect(subject.render?).to be true }
      it do
        expect(component).to eq_html <<~HTML
          <div>Can't be blank<br>Is too short (minimum is 2 characters)</div>
        HTML
      end
    end

    include_examples "component with custom html classes"
    include_examples "component with custom data attributes"
  end
end
