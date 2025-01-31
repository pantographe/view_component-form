# frozen_string_literal: true

require_relative "../../fixtures/test_model"

RSpec.describe ViewComponent::Form::Builder, type: :builder do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  shared_examples "the default form builder" do |method_name, *args, rspec_around: lambda(&:run), **kwargs, &block|
    around(&rspec_around)
    subject { form.public_send(method_name, *args, **kwargs, &block) }

    let(:default_form_builder) { form_with(object, builder: ActionView::Helpers::FormBuilder) }
    let(:default_form_builder_output) { default_form_builder.public_send(method_name, *args, **kwargs, &block) }

    context "when calling ##{method_name}" do
      # NOTE: freeze time to force #time_select test use same time
      it do
        freeze_time do
          expect(subject).to eq(default_form_builder_output)
        end
      end
    end
  end

  it_behaves_like "the default form builder", :check_box, "validated"
  it_behaves_like "the default form builder", :check_box, "gooddog", {}, "yes", "no"
  it_behaves_like "the default form builder", :check_box, "accepted", { class: "eula_check" }, "yes", "no"
  context "with model-dependent fields" do
    before do
      Author.create(name_with_initial: "Touma K.")
      Author.create(name_with_initial: "Rintaro S.")
      Author.create(name_with_initial: "Kento F.")
    end

    it_behaves_like "the default form builder", :collection_check_boxes, :author_ids, Author.all, :id,
                    :name_with_initial
    it_behaves_like "the default form builder", :collection_radio_buttons, :author_id, Author.all, :id,
                    :name_with_initial
    it_behaves_like "the default form builder", :collection_select, :person_id, Author.all, :id, :name_with_initial,
                    { prompt: true }
  end

  it_behaves_like "the default form builder", :color_field, :favorite_color
  it_behaves_like "the default form builder", :date_field, :born_on
  it_behaves_like "the default form builder", :date_select, :birth_date
  it_behaves_like "the default form builder", :datetime_field, :graduation_day
  it_behaves_like "the default form builder", :datetime_local_field, :graduation_day
  it_behaves_like "the default form builder", :datetime_select, :last_request_at
  it_behaves_like "the default form builder", :email_field, :address
  it_behaves_like "the default form builder", :file_field, :avatar
  it_behaves_like "the default form builder", :file_field, :image, { multiple: true }
  it_behaves_like "the default form builder", :file_field, :attached, { accept: "text/html" }
  it_behaves_like "the default form builder", :file_field, :image, { accept: "image/png,image/gif,image/jpeg" }
  it_behaves_like "the default form builder", :file_field, :file, { class: "file_input" }

  context "with fields dependent on Continent" do
    let(:object) { City.new(country: Country.find_by!(name: "Denmark")) }

    before do
      Continent.create(name: "Africa")
               .countries.tap do |countries|
                 countries.create(name: "South Africa")
                 countries.create(name: "Somalia")
               end
      Continent.create(name: "Europe")
               .countries.tap do |countries|
                 countries.create(name: "Denmark")
                 countries.create(name: "Ireland")
               end
    end

    it_behaves_like "the default form builder", :grouped_collection_select,
                    :country_id, Continent.all, :countries, :name, :id, :name
  end

  context "with values from the object" do
    let(:object) { HiddenFieldTest.new(pass_confirm: true, tag_list: "blog, ruby", token: "abcde") }

    it_behaves_like "the default form builder", :hidden_field, :pass_confirm
    it_behaves_like "the default form builder", :hidden_field, :tag_list
    it_behaves_like "the default form builder", :hidden_field, :token
  end

  it_behaves_like "the default form builder", :label, :title
  it_behaves_like "the default form builder", :label, :body
  # rubocop:disable RSpec/PendingWithoutReason
  skip "This would demonstrate translations via i18n.yml" do
    it_behaves_like "the default form builder", :label, :cost
  end
  # rubocop:enable RSpec/PendingWithoutReason

  it_behaves_like "the default form builder", :label, :title, "A short title"
  it_behaves_like "the default form builder", :label, :privacy, "Public Post", value: "public"

  # rubocop:disable RSpec/ExampleLength
  # rubocop:disable RSpec/PendingWithoutReason
  skip "These helpers also take blocks" do
    it_behaves_like("the default form builder", :label, [:cost]) do |translation|
      content_tag(:span, translation, class: "cost_label")
    end
    it_behaves_like("the default form builder", :label, [:cost]) do |builder|
      content_tag(:span, builder, class: "cost_label")
    end
    it_behaves_like("the default form builder", :label, [:cost]) do |builder|
      content_tag(:span, builder.translation, class: [
                    "cost_label",
                    ("error_label" if builder.object.errors.include?(:cost))
                  ])
    end
    it_behaves_like("the default form builder", :label, [:terms]) { raw('Accept <a href="/terms">Terms</a>.') }
  end
  # rubocop:enable RSpec/PendingWithoutReason
  # rubocop:enable RSpec/ExampleLength

  it_behaves_like "the default form builder", :month_field, :birthday_month
  it_behaves_like "the default form builder", :number_field, :age
  it_behaves_like "the default form builder", :password_field, :password
  it_behaves_like "the default form builder", :phone_field, :phone
  it_behaves_like "the default form builder", :radio_button, "category", "rails"
  it_behaves_like "the default form builder", :radio_button, "category", "java"
  it_behaves_like "the default form builder", :radio_button, "receive_newsletter", "yes"
  it_behaves_like "the default form builder", :radio_button, "receive_newsletter", "no"
  it_behaves_like "the default form builder", :range_field, :age

  context "with fields dependent on Person" do
    before do
      Person.create(name: "Touma")
      Person.create(name: "Rintaro")
      Person.create(name: "Kento")
    end

    it_behaves_like "the default form builder", :select, :person_id, Person.pluck(:name, :id), { include_blank: true }
  end

  it_behaves_like "the default form builder", :submit
  it_behaves_like "the default form builder", :text_area, :detail
  it_behaves_like "the default form builder", :text_field, :name
  it_behaves_like "the default form builder", :time_field, :born_at
  it_behaves_like "the default form builder", :time_select, :average_lap
  it_behaves_like "the default form builder", :time_zone_select, :time_zone, nil, { include_blank: true }
  it_behaves_like "the default form builder", :url_field, :homepage
  it_behaves_like "the default form builder", :week_field, :birthday_week
  it_behaves_like "the default form builder", :weekday_select, :weekday, { include_blank: true }

  describe "#component_klass" do
    context "with gem Builder" do
      let(:builder) { described_class.new(object_name, object, template, options) }

      it { expect(builder.send(:component_klass, :label)).to eq(ViewComponent::Form::LabelComponent) }
      it { expect(builder.send(:component_klass, :text_field)).to eq(ViewComponent::Form::TextFieldComponent) }
      it { expect(builder.send(:component_klass, :submit)).to eq(ViewComponent::Form::SubmitComponent) }
    end

    context "with custom Builder" do
      let(:builder) { CustomFormBuilder.new(object_name, object, template, options) }

      it { expect(builder.send(:component_klass, :label)).to eq(Form::LabelComponent) }
      it { expect(builder.send(:component_klass, :text_field)).to eq(Form::TextFieldComponent) }
      it { expect(builder.send(:component_klass, :submit)).to eq(ViewComponent::Form::SubmitComponent) }
    end

    context "with embeded builder" do
      let(:builder) { InlineCustomFormBuilder.new(object_name, object, template, options) }

      it { expect(builder.send(:component_klass, :label)).to eq(InlineForm::LabelComponent) }
      it { expect(builder.send(:component_klass, :text_field)).to eq(Form::TextFieldComponent) }
      it { expect(builder.send(:component_klass, :submit)).to eq(ViewComponent::Form::SubmitComponent) }
    end

    context "with a custom lookup_chain" do
      let(:builder) { CustomFormBuilder.new(object_name, object, template, options) }

      around do |example|
        original = ViewComponent::Form.configuration.lookup_chain
        ViewComponent::Form.configuration.lookup_chain.prepend(lambda do |component_name, namespaces: []|
          namespaces.lazy.map do |namespace|
            "#{namespace}::#{component_name.to_s.camelize}".safe_constantize
          end.find(&:itself)
        end)

        example.run

        ViewComponent::Form.configuration.lookup_chain = original
      end

      it { expect(builder.send(:component_klass, :label)).to eq(Form::LabelComponent) }
      it { expect(builder.send(:component_klass, :text_field)).to eq(Form::TextField) }
      it { expect(builder.send(:component_klass, :submit)).to eq(ViewComponent::Form::SubmitComponent) }
    end
  end

  describe "#field_id" do
    it_behaves_like "the default form builder", :field_id, :first_name, :hint
  end

  describe "#validation_context" do
    let(:builder) { described_class.new(object_name, object, template, options) }

    context "without context" do
      it { expect(builder.send(:validation_context)).to be_nil }
    end

    context "with context" do
      let(:options) { { validation_context: :create } }

      it { expect(builder.send(:validation_context)).to eq(:create) }
    end
  end

  describe "base component parent" do
    subject(:field) { described_class.new(object_name, object, template, options).send(:component_klass, :text_field) }

    it "is configured via initializer" do
      expect(field.ancestors).to include(ApplicationFormComponent)
    end
  end
end
