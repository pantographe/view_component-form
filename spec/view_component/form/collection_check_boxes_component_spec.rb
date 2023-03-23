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
      expect(component.to_html).to have_tag("input", with: { type: "hidden", value: "", name: "user[nationalities][]" })
    end

    it do
      expect(component.to_html)
        .to have_tag("input", with: {
                       type: "checkbox", value: "BE",
                       id: "user_nationalities_be", name: "user[nationalities][]"
                     })
    end

    it do
      expect(component.to_html)
        .to have_tag("input", with: {
                       type: "checkbox", value: "FR",
                       id: "user_nationalities_fr", name: "user[nationalities][]"
                     })
    end

    it do
      expect(component.to_html)
        .to have_tag("label", with: { for: "user_nationalities_be" }, text: "Belgium")
    end

    it do
      expect(component.to_html)
        .to have_tag("label", with: { for: "user_nationalities_fr" }, text: "France")
    end
  end

  context "with a build proc" do
    let(:options) do
      {
        build_proc: proc do |b|
          "<div class='wrapper'>
            #{b.check_box}
            #{b.label}
          </div>".html_safe
        end
      }
    end

    it do
      expect(component.to_html)
        .to have_tag(".wrapper input", with: {
                       type: "checkbox", value: "BE",
                       id: "user_nationalities_be", name: "user[nationalities][]"
                     })
    end
  end

  include_examples "component with custom html classes", :html_options
  include_examples "component with custom data attributes", :html_options
end
