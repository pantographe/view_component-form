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

  context "with simple args" do
    it do # rubocop:disable RSpec/ExampleLength
      expect(component.to_html).to eq(
        "<select name=\"user[country]\" id=\"user_country\"><optgroup label=\"Europe\">\n" \
        "<option value=\"BE\">Belgium</option>\n" \
        "<option value=\"FR\">France</option>\n" \
        "</optgroup>\n" \
        "<optgroup label=\"Asia\"><option value=\"JP\">Japan</option></optgroup></select>"
      )
    end
  end

  context "with custom html classes" do
    let(:html_options) { { class: "custom-css-class" } }

    it { expect(component_html_attributes["class"].to_s).to include("custom-css-class") }
  end

  context "with custom data attributes" do
    let(:html_options) { { data: { key: "value" } } }

    it { expect(component_html_attributes["data-key"].to_s).to include("value") }
  end
end
