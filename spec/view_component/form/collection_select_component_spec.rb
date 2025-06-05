# frozen_string_literal: true

RSpec.describe ViewComponent::Form::CollectionSelectComponent, type: :component do
  let(:object)       { OpenStruct.new }
  let(:form)         { form_with(object) }
  let(:collection)   { [OpenStruct.new(name: "Belgium", code: "BE"), OpenStruct.new(name: "France", code: "FR")] }
  let(:options)      { {} }
  let(:html_options) { {} }

  let(:component) do
    render_inline(described_class.new(
                    form,
                    object_name,
                    :country,
                    collection,
                    :code,
                    :name,
                    options,
                    html_options
                  ))
  end
  let(:component_html_attributes) { component.css("select").last.attributes }

  context "with simple args" do
    it do
      expect(component).to eq_html <<~HTML
        <select name="user[country]" id="user_country"><option value="BE">Belgium</option>
        <option value="FR">France</option></select>
      HTML
    end
  end

  it_behaves_like "component with custom html classes", :html_options
  it_behaves_like "component with custom data attributes", :html_options
end
