# frozen_string_literal: true

RSpec.describe ViewComponent::Form::CollectionCheckBoxesComponent, type: :component do
  let(:object)       { OpenStruct.new }
  let(:form)         { form_with(object) }
  let(:collection)   { [OpenStruct.new(name: "Belgium", code: "BE"), OpenStruct.new(name: "France", code: "FR")] }
  let(:options)      { {} }
  let(:html_options) { {} }

  let(:component) do
    render_inline(described_class.new(
                    form,
                    object_name,
                    :nationalities,
                    collection,
                    :code,
                    :name,
                    options,
                    html_options
                  ))
  end
  let(:component_html_attributes) { component.css("input").last.attributes }

  context "with simple args" do
    it do
      expect(component.to_html).to eq(
        "<input type=\"hidden\" name=\"user[nationalities][]\" value=\"\">" \
        "<input type=\"checkbox\" value=\"BE\" name=\"user[user]\" id=\"user_nationalities_be\">" \
        "<label for=\"user_nationalities_be\">Belgium</label>" \
        "<input type=\"checkbox\" value=\"FR\" name=\"user[user]\" id=\"user_nationalities_fr\">" \
        "<label for=\"user_nationalities_fr\">France</label>\n"
      )
    end
  end

  include_examples "component with custom html classes", :html_options
  include_examples "component with custom data attributes", :html_options
end
