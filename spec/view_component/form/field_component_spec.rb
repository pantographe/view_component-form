# frozen_string_literal: true

RSpec.describe ViewComponent::Form::FieldComponent, type: :component do
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

  let(:component) { described_class.new(form, object_name, :first_name, options) }

  describe "#method_errors" do
    before { object.validate }

    context "with valid object" do
      let(:object) { object_klass.new(first_name: "John") }

      it { expect(component.method_errors).to eq([]) }
    end

    context "with unvalid object" do
      let(:object) { object_klass.new(first_name: "") }

      it { expect(component.method_errors).to eq(["Can't be blank", "Is too short (minimum is 2 characters)"]) }
    end
  end

  describe "#method_errors?" do
    before { object.validate }

    context "with valid object" do
      let(:object) { object_klass.new(first_name: "John") }

      it { expect(component.method_errors?).to eq(false) }
    end

    context "with unvalid object" do
      let(:object) { object_klass.new(first_name: "") }

      it { expect(component.method_errors?).to eq(true) }
    end
  end

  describe "#value" do
    let(:object) { object_klass.new(first_name: "John") }

    it { expect(component.value).to eq("John") }
  end

  describe "#object_method_names" do
    it { expect(component.object_method_names).to eq(%i[first_name]) }

    pending "test with belongs_to for _id"
    pending "test with has_many for _ids"
  end
end
