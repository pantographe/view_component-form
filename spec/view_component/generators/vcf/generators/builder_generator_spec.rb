require "spec_helper"
require "generators/vcf/builder/builder_generator"

RSpec.describe Vcf::Generators::BuilderGenerator, type: :generator do
  destination File.expand_path("../../../../../tmp", __dir__)

  before do
    prepare_destination
    run_generator %w[CustomFormBuilder]
  end

  describe "the builder" do
    subject { file("lib/custom_form_builder.rb") }

    it { is_expected.to exist }
    it { is_expected.to contain(/class CustomFormBuilder < ViewComponent::Form::Builder/) }
    it { is_expected.to contain(/namespace "Form"/) }
  end
end
