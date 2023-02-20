# frozen_string_literal: true

require "generators/vcf/builder/builder_generator"

RSpec.describe Vcf::Generators::BuilderGenerator, type: :generator do
  destination Dir.mktmpdir
  arguments %w[CustomFormBuilder]

  before do
    prepare_destination
  end

  describe "the builder" do
    context "without options" do
      before do
        run_generator
      end

      it do
        assert_file "app/helper/custom_form_builder.rb" do |builder|
          assert_match(/class CustomFormBuilder < ViewComponent::Form::Builder/, builder)
          assert_match(/namespace "Form"/, builder)
        end
      end
    end

    context "with namespace option" do
      before do
        run_generator %w[CustomFormBuilder --namespace=CustomForm]
      end

      it do
        assert_file "app/helper/custom_form_builder.rb" do |builder|
          assert_match(/namespace "CustomForm"/, builder)
        end
      end
    end

    context "with path option" do
      before do
        run_generator %w[CustomFormBuilder --path=custom/lib]
      end

      it do
        assert_file "custom/lib/custom_form_builder.rb"
      end
    end
  end
end
