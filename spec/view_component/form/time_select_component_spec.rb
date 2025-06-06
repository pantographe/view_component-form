# frozen_string_literal: true

RSpec.describe ViewComponent::Form::TimeSelectComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:html_options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :wakes_up_at, options, html_options)) }
  let(:component_html_attributes) { component.css("select").first.attributes }

  context "with simple args" do
    it "has a select for the hours" do
      expect(component.to_html).to have_tag("select",
                                            with: { id: "user_wakes_up_at_4i", name: "user[wakes_up_at(4i)]" })
    end

    it "has a select for the minutes" do
      expect(component.to_html).to have_tag("select",
                                            with: { id: "user_wakes_up_at_5i", name: "user[wakes_up_at(5i)]" })
    end
  end

  it_behaves_like "component with custom html classes", :html_options
  it_behaves_like "component with custom data attributes", :html_options
end
