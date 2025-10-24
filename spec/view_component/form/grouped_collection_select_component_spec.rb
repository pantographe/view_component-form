# frozen_string_literal: true

RSpec.describe ViewComponent::Form::GroupedCollectionSelectComponent, type: :component do
  let(:object)       { OpenStruct.new }
  let(:form)         { form_with(object) }
  let(:collection)   do
    [
      OpenStruct.new(
        name: "Europe",
        countries: [
          OpenStruct.new(name: "Belgium", code: "BE"),
          OpenStruct.new(name: "France", code: "FR")
        ]
      ),
      OpenStruct.new(
        name: "Asia",
        countries: [
          OpenStruct.new(name: "Japan", code: "JP")
        ]
      )
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

  # rubocop:disable RSpec/ExampleLength
  context "with simple args" do
    it do
      if Gem::Version.new(::ViewComponent::VERSION::STRING) >= Gem::Version.new("4.0")
        expect(component).to eq_html <<~HTML
          <select name="user[country]" id="user_country"><optgroup label="Europe"><option value="BE">Belgium</option>
          <option value="FR">France</option></optgroup><optgroup label="Asia"><option value="JP">Japan</option></optgroup></select>
        HTML
      else
        expect(component).to eq_html <<~HTML
          <select name="user[country]" id="user_country"><optgroup label="Europe">
          <option value="BE">Belgium</option>
          <option value="FR">France</option>
          </optgroup>
          <optgroup label="Asia"><option value="JP">Japan</option></optgroup></select>
        HTML
      end
    end
  end
  # rubocop:enable RSpec/ExampleLength

  it_behaves_like "component with custom html classes", :html_options
  it_behaves_like "component with custom data attributes", :html_options
end
