require "spec_helper"
require "generators/vcf/builder/builder_generator"

RSpec.describe Vcf::Generators::BuilderGenerator, type: :generator do
  destination File.expand_path("../../../../../tmp", __dir__)

  let(:generator) { %w[CustomFormBuilder] }

  before do
    prepare_destination
    run_generator generator
  end

  describe "the builder" do
    subject { file("lib/custom_form_builder.rb") }

    it { is_expected.to exist }
    it { is_expected.to contain(/class CustomFormBuilder < ViewComponent::Form::Builder/) }
    it { is_expected.to contain(/namespace "Form"/) }

    context "with namespace option" do
      let(:generator) { %w[CustomFormBuilder --namespace=CustomForm] }

      it { is_expected.to contain(/namespace "CustomForm"/) }
    end

    context "with path option" do
      subject { file("custom/lib/custom_form_builder.rb") }

      let(:generator) { %w[CustomFormBuilder --path=custom/lib] }

      it { is_expected.to exist }
    end
  end
end
