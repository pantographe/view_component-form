# frozen_string_literal: true

RSpec.describe ViewComponent::Form::TimeZoneSelectComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }
  let(:html_options) { {} }

  let(:component) { render_inline(described_class.new(form, object_name, :time_zone, nil, options, html_options)) }
  let(:component_html_attributes) { component.css("select").first.attributes }

  context "with simple args" do
    it "has a select" do
      expect(component.to_html).to have_tag("select",
                                            with: { id: "user_time_zone", name: "user[time_zone]" }) do
                                              with_tag "option", with: { value: "Warsaw" }
                                            end
    end
  end

  it_behaves_like "component with custom html classes", :html_options
  it_behaves_like "component with custom data attributes", :html_options
end
