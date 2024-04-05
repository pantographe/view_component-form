# frozen_string_literal: true

RSpec.describe ViewComponent::Form do
  it "has a version number" do
    expect(ViewComponent::Form::VERSION).not_to be_nil
  end

  it "is configurable" do
    expect { |block| described_class.configure(&block) }.to yield_with_args(ViewComponent::Form::Configuration)
  end

  if ENV.fetch("VIEW_COMPONENT_FORM_USE_ACTIONTEXT", "false") == "true"
    it "loads ActionText" do
      expect(defined?(ActionView::Helpers::Tags::ActionText)).to eq("constant")
    end
  else
    it "does not load ActionText" do
      expect(defined?(ActionView::Helpers::Tags::ActionText)).to be_nil
    end
  end
end
