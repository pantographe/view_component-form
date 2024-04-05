# frozen_string_literal: true

RSpec.describe ViewComponent::Form::Configuration do
  subject(:configuration) { described_class.new }

  describe "defaults" do
    it do
      expect(configuration).to have_attributes(parent_component: "ViewComponent::Base")
    end
  end
end
