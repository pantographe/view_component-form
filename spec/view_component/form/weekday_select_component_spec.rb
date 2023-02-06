# frozen_string_literal: true

if Rails::VERSION::MAJOR >= 7
  RSpec.describe ViewComponent::Form::WeekdaySelectComponent, type: :component do
    let(:object)  { OpenStruct.new }
    let(:form)    { form_with(model: object) }
    let(:options) { {} }
    let(:html_options) { {} }

    let(:component) { render_inline(described_class.new(form, :user, :weekday, options, html_options)) }
    let(:component_html_attributes) { component.css("select").first.attributes }

    context "with simple args" do
      it "has a select for the weekdays" do
        expect(component.to_html).to have_tag("select",
                                              with: { id: "user_weekday", name: "user[weekday]" })
      end
    end

    include_examples "component with custom html classes", :html_options
    include_examples "component with custom data attributes", :html_options
  end
end
