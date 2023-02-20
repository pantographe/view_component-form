# frozen_string_literal: true

if defined?(ActionView::Helpers::Tags::ActionText)
  RSpec.describe ViewComponent::Form::RichTextAreaComponent, type: :component do
    let(:object)  { OpenStruct.new }
    let(:form)    { form_with(model: object) }
    let(:options) { {} }

    let(:component) { render_inline(described_class.new(form, :user, :bio, options)) }
    let(:component_html_attributes) { component.css("trix-editor").first.attributes }

    context "with simple args" do
      it "has a hidden field", :aggregate_failures do
        expect(component.to_html).to have_tag("input",
                                              with: { type: "hidden", id: "trix_input_1", name: "user[bio]" })
        expect(component.to_html).to have_tag("trix-editor",
                                              with: { id: "user_bio", input: "trix_input_1", class: "trix-content" })
      end
    end

    include_examples "component with custom html classes"
    include_examples "component with custom data attributes"
  end
end
