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

  context "with a block" do
    let(:block) do
      proc do |c|
        c.builder.label { c.builder.check_box + c.builder.text }
      end
    end

    it do
      expect(component).to eq_html <<~HTML
        <input type="hidden" name="user[nationalities][]" value="" autocomplete="off"><label for="user_nationalities_be"><input type="checkbox" value="BE" name="user[nationalities][]" id="user_nationalities_be">Belgium</label><label for="user_nationalities_fr"><input type="checkbox" value="FR" name="user[nationalities][]" id="user_nationalities_fr">France</label>
      HTML
    end
  end

  # context "with a block and translation param" do
  #   let(:block) do
  #     proc do |component|
  #       "<span class=\"translated-label\">#{component.translation}</span>".html_safe
  #     end
  #   end

  #   it do
  #     expect(component).to eq_html <<~HTML
  #       <label for="user_first_name"><span class="translated-label">First name</span></label>
  #     HTML
  #   end
  # end

  # context "with a block and builder param" do
  #   let(:block) do
  #     proc do |component|
  #       "<span class=\"translated-label#{" has-error" if component.builder.object.errors.include?(:first_name)}\">" \
  #       "#{component.builder.translation}</span>".html_safe
  #     end
  #   end

  #   it do
  #     expect(component).to eq_html <<~HTML
  #       <label for="user_first_name"><span class="translated-label">First name</span></label>
  #     HTML
  #   end
  # end

  include_examples "component with custom html classes", :html_options
  include_examples "component with custom data attributes", :html_options
end
