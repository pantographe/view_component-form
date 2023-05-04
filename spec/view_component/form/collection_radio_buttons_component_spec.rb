# frozen_string_literal: true

RSpec.describe ViewComponent::Form::CollectionRadioButtonsComponent, type: :component do
  let(:object)       { OpenStruct.new }
  let(:form)         { form_with(object) }
  let(:collection)   { [OpenStruct.new(name: "Belgium", code: "BE"), OpenStruct.new(name: "France", code: "FR")] }
  let(:options)      { {} }
  let(:html_options) { {} }

  let(:component) do
    render_inline(described_class.new(
                    form,
                    object_name,
                    :nationality,
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
      expect(component.to_html).to have_tag("input", with: { type: "hidden", value: "", name: "user[nationality]" })
    end

    it do
      expect(component.to_html)
        .to have_tag("input", with: {
                       type: "radio", value: "BE",
                       id: "user_nationality_be", name: "user[nationality]"
                     })
    end

    it do
      expect(component.to_html)
        .to have_tag("input", with: {
                       type: "radio", value: "FR",
                       id: "user_nationality_fr", name: "user[nationality]"
                     })
    end

    it do
      expect(component.to_html)
        .to have_tag("label", with: { for: "user_nationality_be" }, text: "Belgium")
    end

    it do
      expect(component.to_html)
        .to have_tag("label", with: { for: "user_nationality_fr" }, text: "France")
    end
  end

  context "with an element proc" do
    let(:options) do
      {
        element_proc: proc do |b|
          "<div class='wrapper'>
            #{b.radio_button}
            #{b.label}
          </div>".html_safe
        end
      }
    end

    it do
      expect(component.to_html)
        .to have_tag(".wrapper input", with: {
                       type: "radio", value: "BE",
                       id: "user_nationality_be", name: "user[nationality]"
                     })
    end
  end

  include_examples "component with custom html classes", :html_options
  include_examples "component with custom data attributes", :html_options
end
