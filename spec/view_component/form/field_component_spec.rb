# frozen_string_literal: true

RSpec.describe ViewComponent::Form::FieldComponent, type: :component do
  let(:object_klass) do
    Class.new do
      include ActiveModel::Model

      attr_accessor :first_name, :last_name, :email, :city

      validates :first_name, presence: true, length: { minimum: 2 }
      validates :email, presence: true, on: :custom_context
      validates :city, presence: true, on: %i[custom_context another_context]

      class << self
        def name
          "User"
        end
      end
    end
  end

  let(:object)      { object_klass.new }
  let(:form)        { form_with(object) }
  let(:method_name) { :first_name }
  let(:options)     { {} }

  let(:component) { described_class.new(form, object_name, method_name, options) }

  describe "#tag_klass" do
    subject { Class.new(ChildClass).tag_klass }

    before do
      stub_const("ChildClass", Class.new(described_class) do
                                 self.tag_klass = ActionView::Helpers::Tags::TextField
                               end)
    end

    it { is_expected.to be ActionView::Helpers::Tags::TextField }
  end

  describe "#method_errors" do
    context "with valid object" do
      let(:object) { object_klass.new(first_name: "John") }

      before { object.validate }

      it { expect(component.method_errors).to eq([]) }
    end

    context "with invalid object" do
      let(:object) { object_klass.new(first_name: "") }

      before { object.validate }

      it {
        expect(component.method_errors).to eq([I18n.t("errors.messages.blank").upcase_first,
                                               "Is too short (minimum is 2 characters)"])
      }
    end

    context "without object" do
      let(:object) { nil }

      it { expect(component.method_errors).to eq([]) }
    end
  end

  describe "#method_errors?" do
    context "with valid object" do
      let(:object) { object_klass.new(first_name: "John") }

      before { object.validate }

      it { expect(component.method_errors?).to be(false) }
    end

    context "with invalid object" do
      let(:object) { object_klass.new(first_name: "") }

      before { object.validate }

      it { expect(component.method_errors?).to be(true) }
    end

    context "without object" do
      let(:object) { nil }

      it { expect(component.method_errors?).to be(false) }
    end

    context "with false" do
      let(:object) { false }

      it { expect(component.method_errors?).to be(false) }
    end
  end

  describe "#value" do
    let(:object) { object_klass.new(first_name: "John") }

    it { expect(component.value).to eq("John") }
  end

  describe "#object_method_names" do
    it { expect(component.object_method_names).to eq(%i[first_name]) }

    it "works with belongs_to for _id", skip: "still to be implemented"
    it "works with has_many for _ids", skip: "still to be implemented"
  end

  describe "#label_text" do
    context "without translation" do
      it { expect(component.label_text).to eq("First name") }
    end

    context "with custom translation" do
      include_context "with translations"

      let(:translations) { { helpers: { label: { user: { first_name: "Your first name" } } } } }

      it { expect(component.label_text).to eq("Your first name") }
    end
  end

  describe "#optional?" do
    let(:object) { object_klass.new(first_name: "John", last_name: "Doe") }

    context "with required method name" do
      let(:method_name) { :first_name }

      it { expect(component.optional?).to be(false) }
    end

    context "with optional method name" do
      let(:method_name) { :last_name }

      it { expect(component.optional?).to be(true) }
    end

    context "with context" do
      let(:method_name) { :email }

      it { expect(component.optional?).to be(true) }
      it { expect(component.optional?(context: :custom_context)).to be(false) }
    end

    context "with context from the form" do
      let(:form) { form_with(object, validation_context: :custom_context) }
      let(:method_name) { :email }

      it { expect(component.optional?).to be(false) }
    end

    context "with multiple contexts" do
      let(:method_name) { :city }

      it { expect(component.optional?).to be(true) }
      it { expect(component.optional?(context: :custom_context)).to be(false) }
      it { expect(component.optional?(context: :another_context)).to be(false) }
    end
  end

  describe "#required?" do
    let(:object) { object_klass.new(first_name: "John", last_name: "Doe") }

    context "with required method name" do
      let(:method_name) { :first_name }

      it { expect(component.required?).to be(true) }
    end

    context "with optional method name" do
      let(:method_name) { :last_name }

      it { expect(component.required?).to be(false) }
    end

    context "with context" do
      let(:method_name) { :email }

      it { expect(component.required?).to be(false) }
      it { expect(component.required?(context: :custom_context)).to be(true) }
    end

    context "with context from the form" do
      let(:form) { form_with(object, validation_context: :custom_context) }
      let(:method_name) { :email }

      it { expect(component.required?).to be(true) }
    end

    context "with multiple contexts" do
      let(:method_name) { :city }

      it { expect(component.required?).to be(false) }
      it { expect(component.required?(context: :custom_context)).to be(true) }
      it { expect(component.required?(context: :another_context)).to be(true) }
    end
  end

  describe "#validators" do
    let(:object) { object_klass.new(first_name: "John", last_name: "Doe") }

    it { expect(component.validators.first).to be_a(ActiveModel::Validations::PresenceValidator) }
    it { expect(component.validators.last).to be_a(ActiveModel::Validations::LengthValidator) }

    context "with context" do
      let(:method_name) { :email }

      it { expect(component.validators).to eq([]) }

      it do
        expect(component.validators(context: :custom_context).first)
          .to be_a(ActiveModel::Validations::PresenceValidator)
      end
    end

    context "with context from the form" do
      let(:form) { form_with(object, validation_context: :custom_context) }
      let(:method_name) { :email }

      it do
        expect(component.validators.first)
          .to be_a(ActiveModel::Validations::PresenceValidator)
      end
    end

    context "with multiple contexts" do
      let(:method_name) { :city }

      it { expect(component.validators).to eq([]) }

      it do
        expect(component.validators(context: :custom_context).first)
          .to be_a(ActiveModel::Validations::PresenceValidator)
      end

      it do
        expect(component.validators(context: :another_context).first)
          .to be_a(ActiveModel::Validations::PresenceValidator)
      end
    end
  end

  describe "#validation_context" do
    context "without context" do
      it { expect(component.validation_context).to be_nil }
    end

    context "with context from the form" do
      let(:form) { form_with(object, validation_context: :custom_context) }

      it { expect(component.validation_context).to eq(:custom_context) }
    end
  end
end
