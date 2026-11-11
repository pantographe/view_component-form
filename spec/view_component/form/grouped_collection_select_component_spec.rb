# frozen_string_literal: true

RSpec.describe ViewComponent::Form::GroupedCollectionSelectComponent, type: :component do
  let(:object)       { Object.new }
  let(:form)         { form_with(object) }
  let(:collection)   do
    continent = Struct.new(:name, :countries)
    country = Struct.new(:name, :code)

    [
      continent.new("Europe", [country.new("Belgium", "BE"), country.new("France", "FR")]),
      continent.new("Asia", [country.new("Japan", "JP")])
    ]
  end
  let(:options)      { {} }
  let(:html_options) { {} }

  let(:component) do
    render_inline(described_class.new(
                    form,
                    object_name,
                    :country,
                    collection,
                    :countries,
                    :name,
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
        <select name="user[country]" id="user_country"><optgroup label="Europe"><option value="BE">Belgium</option>
        <option value="FR">France</option></optgroup><optgroup label="Asia"><option value="JP">Japan</option></optgroup></select>
      HTML
    end
  end
  # rubocop:enable RSpec/ExampleLength

  it_behaves_like "component with custom html classes", :html_options
  it_behaves_like "component with custom data attributes", :html_options
end
