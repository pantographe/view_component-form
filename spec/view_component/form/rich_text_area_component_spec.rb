# frozen_string_literal: true

RSpec.describe ViewComponent::Form::RichTextAreaComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :bio, options)) }
  let(:component_html_attributes) { component.css("trix-editor").first.attributes }

  context "with simple args" do
    it do # rubocop:disable RSpec/ExampleLength
      expect(component.to_html).to start_with(
        "<input type=\"hidden\" name=\"user[bio]\" id=\"trix_input_1\">" \
        "<trix-editor id=\"user_bio\" input=\"trix_input_1\" class=\"trix-content\" " \
        "data-direct-upload-url=\"http://test.host/rails/active_storage/direct_uploads\" " \
        "data-blob-url-template=\"http://test.host/rails/active_storage/blobs/"
      )
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
end
