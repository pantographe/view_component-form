# frozen_string_literal: true

RSpec.describe ViewComponent::Form::FileFieldComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :avatar, options)) }
  let(:component_html_attributes) { component.css("input").first.attributes }

  context "with simple args" do
    it do
      expect(component).to eq_html <<~HTML
        <input type="file" name="user[avatar]" id="user_avatar">
      HTML
    end
  end

  context "with direct upload" do
    let(:options) { { direct_upload: true } }

    it do
      expect(component).to eq_html <<~HTML
        <input data-direct-upload-url="http://test.host/rails/active_storage/direct_uploads" type="file" name="user[avatar]" id="user_avatar">
      HTML
    end
  end

  context "with multiple and include hidden" do
    let(:options) { { multiple: true, include_hidden: true } }

    it do
      if Gem::Version.new(ViewComponent::VERSION::STRING) >= Gem::Version.new("4.0")
        expect(component).to eq_html <<~HTML
          <input name="user[avatar][]" type="hidden" value="" autocomplete="off"><input multiple="multiple" type="file" name="user[avatar][]" id="user_avatar">
        HTML
      else
        expect(component).to eq_html <<~HTML
          <input name="user[avatar][]" type="hidden" value="" autocomplete="off"><input multiple type="file" name="user[avatar][]" id="user_avatar">
        HTML
      end
    end
  end

  it_behaves_like "component with custom html classes"
  it_behaves_like "component with custom data attributes"
end
