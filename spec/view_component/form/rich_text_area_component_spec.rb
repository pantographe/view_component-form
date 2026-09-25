# frozen_string_literal: true

if defined?(ActionView::Helpers::Tags::ActionText)
  RSpec.describe ViewComponent::Form::RichTextAreaComponent, type: :component do
    let(:object)  { OpenStruct.new }
    let(:form)    { form_with(object) }
    let(:options) { {} }
    let(:block)   { nil }

    let(:component) { render_inline(described_class.new(form, object_name, :bio, options), &block) }
    let(:component_html_attributes) { component.css("trix-editor").first.attributes }

    context "with simple args" do
      it "has a hidden field", :aggregate_failures do
        expect(component.to_html)
          .to have_tag("input", with: { type: "hidden", id: "trix_input_1", name: "user[bio]" })
        expect(component.to_html)
          .to have_tag("trix-editor", with: { id: "user_bio", input: "trix_input_1", class: "trix-content" })
      end
    end

    it_behaves_like "component with custom html classes"
    it_behaves_like "component with custom data attributes"

    context "with a block" do
      let(:block) do
        proc do
          "Your <strong>first</strong> text".html_safe
        end
      end

      it do
        expect(component.to_html)
          .to have_tag("input", with: {
                         type: "hidden", name: "user[bio]", id: "trix_input_4",
                         value: "Your <strong>first</strong> text", autocomplete: "off"
                       })
      end
    end
  end
end
