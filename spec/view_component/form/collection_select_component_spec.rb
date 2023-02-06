# frozen_string_literal: true

RSpec.describe ViewComponent::Form::CollectionSelectComponent, type: :component do
  let(:object)       { OpenStruct.new }
  let(:form)         { form_with(model: object) }
  let(:collection)   { [OpenStruct.new(name: "Belgium", code: "BE"), OpenStruct.new(name: "France", code: "FR")] }
  let(:options)      { {} }
  let(:html_options) { {} }

  let(:component) do
    render_inline(described_class.new(
                    form,
                    :user,
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

  include_examples "component with custom html classes", :html_options
  include_examples "component with custom data attributes", :html_options
end
