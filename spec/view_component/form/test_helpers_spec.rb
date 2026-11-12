# frozen_string_literal: true

require_relative "../../fixtures/test_model"

RSpec.describe ViewComponent::Form::TestHelpers, type: :builder do
  describe "#form_with" do
    subject(:form) { form_with(object) }

    context "with a model" do
      let(:object) { TestModel.new }

      it "uses the model param key as object name" do
        expect(form.object_name).to eq("test_model")
      end
    end

    context "with a non-model object" do
      let(:object) { Object.new }

      it "uses the default object name" do
        expect(form.object_name).to eq(object_name)
      end
    end

    context "with model:" do
      subject(:form) { form_with(model: object) }

      let(:object) { TestModel.new }

      it "builds on the model, named after its param key" do
        expect(form.object_name).to eq("test_model")
        expect(form.object).to be(object)
      end
    end

    context "with scope:" do
      let(:object) { TestModel.new }

      it "uses the scope as object name" do
        expect(form_with(object, scope: :signup).object_name).to eq(:signup)
        expect(form_with(model: object, scope: :signup).object_name).to eq(:signup)
      end
    end

    context "with scope: and no object" do
      subject(:form) { form_with(scope: :search) }

      it "uses the scope as object name, without an object" do
        expect(form.object_name).to eq(:search)
        expect(form.object).to be_nil
      end
    end
  end

  describe "#object_name" do
    it { expect(object_name).to eq(:user) }
  end
end
