require 'spec_helper'
require 'generators/vcg/builder/builder_generator'

describe Vcf::Generators::BuilderGenerator, type: :generator do
  destination File.expand_path("../../tmp", __dir__)

  before do
    prepare_destination
    run_generator
  end

  describe 'CustomFormBuilder' do
    before do
      run_generator %w(CustomFormBuilder)
    end

    describe 'the builder' do
      subject { file('lib/custom_form_builder.rb') }

      specify do
        is_expected.to exist
        is_expected.to contain /class CustomFormBuilder < ViewComponent::Form::Builder/
        is_expected.to contain /self.components_namespace = "Form"/
      end
    end
  end
end
