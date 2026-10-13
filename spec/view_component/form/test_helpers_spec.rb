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
      let(:object) { OpenStruct.new }

      it "uses the default object name" do
        expect(form.object_name).to eq(object_name)
      end
    end
  end

  describe "#object_name" do
    it { expect(object_name).to eq(:user) }
  end
end
