# frozen_string_literal: true

require_relative "../../fixtures/test_model"

RSpec.describe ViewComponent::Form::Builder, type: :builder do
  # A plain object with the attributes the examples render fields for (the submit button's default value asks
  # whether it's persisted)
  let(:object) do
    Struct.new(
      :accepted, :address, :age, :author_id, :author_ids, :average_lap, :birth_date, :birthday_month, :birthday_week,
      :born_at, :born_on, :category, :detail, :favorite_color, :gooddog, :graduation_day, :homepage, :last_request_at,
      :name, :person_id, :phone, :receive_newsletter, :role, :time_zone, :validated, :weekday
    ) { def persisted? = false }.new
  end
  let(:builder_options) { {} }
  let(:form)    { form_with(object, **builder_options) }
  let(:options) { {} }

  shared_examples "the default form builder" do |method_name, *args, rspec_around: lambda(&:run), **kwargs, &block|
    around(&rspec_around)
    subject { form.public_send(method_name, *args, **kwargs, &block) }

    let(:default_form_builder) { form_with(object, builder: ActionView::Helpers::FormBuilder, **builder_options) }
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

  shared_examples "it renders a component" do |component_klass, method_name, *args, rspec_around: lambda(&:run), **kwargs, &block| # rubocop:disable Layout/LineLength
    around(&rspec_around)
    subject { form.public_send(method_name, *args, **kwargs, &block) }

    context "when calling ##{method_name}" do
      it "renders the #{component_klass}" do
        instance_spy = instance_spy(component_klass)
        allow(component_klass).to receive(:new).and_return(instance_spy)

        subject

        expect(instance_spy).to have_received(:render_in).once
      end
    end
  end

  it_behaves_like "the default form builder", :check_box, "validated"
  it_behaves_like "the default form builder", :check_box, "gooddog", {}, "yes", "no"
  it_behaves_like "the default form builder", :check_box, "accepted", { class: "eula_check" }, "yes", "no"

  it_behaves_like "it renders a component", ViewComponent::Form::CheckBoxComponent, :check_box, "validated"
  it_behaves_like "the default form builder", :checkbox, "validated"
  it_behaves_like "it renders a component", ViewComponent::Form::CheckBoxComponent, :checkbox, "validated"

  context "with model-dependent fields" do
    before do
      Author.create(name_with_initial: "Touma K.")
      Author.create(name_with_initial: "Rintaro S.")
      Author.create(name_with_initial: "Kento F.")
    end

    it_behaves_like "the default form builder", :collection_check_boxes, :author_ids, Author.all, :id,
                    :name_with_initial
    it_behaves_like "it renders a component", ViewComponent::Form::CollectionCheckBoxesComponent,
                    :collection_check_boxes, :author_ids, Author.all, :id, :name_with_initial

    it_behaves_like "it renders a component", ViewComponent::Form::CollectionCheckBoxesComponent,
                    :collection_checkboxes, :author_ids, Author.all, :id, :name_with_initial
    it_behaves_like "the default form builder", :collection_checkboxes,
                    :author_ids, Author.all, :id, :name_with_initial

    it_behaves_like "the default form builder", :collection_radio_buttons, :author_id, Author.all, :id,
                    :name_with_initial
    it_behaves_like "the default form builder", :collection_select, :person_id, Author.all, :id, :name_with_initial,
                    { prompt: true }
  end

  context "when calling collection helpers with a block" do
    let(:countries) { [%w[BE Belgium], %w[FR France]] }
    let(:default_form_builder) { form_with(object, builder: ActionView::Helpers::FormBuilder) }

    it "yields each item builder to #collection_check_boxes, like the default form builder" do
      item_block = proc { |b| b.label(class: "item") { b.check_box + b.text } }

      expect(form.collection_check_boxes(:nationalities, countries, :first, :last, &item_block))
        .to eq(default_form_builder.collection_check_boxes(:nationalities, countries, :first, :last, &item_block))
    end

    it "yields each item builder to #collection_radio_buttons, like the default form builder" do
      item_block = proc { |b| b.label(class: "item") { b.radio_button + b.text } }

      expect(form.collection_radio_buttons(:nationality, countries, :first, :last, &item_block))
        .to eq(default_form_builder.collection_radio_buttons(:nationality, countries, :first, :last, &item_block))
    end
  end

  it_behaves_like "the default form builder", :color_field, :favorite_color

  context "with the country_select gem" do
    let(:object) { Struct.new(:country).new("FR") }

    it_behaves_like "the default form builder", :country_select, :country
    it_behaves_like "the default form builder", :country_select, :country,
                    { priority_countries: %w[FR BE], include_blank: true }, { class: "countries" }
    it_behaves_like "it renders a component", ViewComponent::Form::CountrySelectComponent, :country_select, :country
  end

  it_behaves_like "the default form builder", :date_field, :born_on
  it_behaves_like "the default form builder", :date_select, :birth_date
  it_behaves_like "the default form builder", :datetime_field, :graduation_day
  it_behaves_like "the default form builder", :datetime_local_field, :graduation_day
  it_behaves_like "the default form builder", :datetime_select, :last_request_at

  context "with the builder's default options" do
    # Set by form_with's namespace: or fields_for's index:, for instance
    let(:builder_options) { { index: 3, namespace: "admin" } }

    it_behaves_like "the default form builder", :date_select, :birth_date
    it_behaves_like "the default form builder", :datetime_select, :last_request_at
    it_behaves_like "the default form builder", :time_select, :average_lap
    it_behaves_like "the default form builder", :select, :role, %w[admin editor]
  end

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
  context "with a label translation" do
    include_context "with translations"

    let(:translations) { { helpers: { label: { user: { cost: "Total cost" } } } } }

    it_behaves_like "the default form builder", :label, :cost

    it { expect(form.label(:cost)).to eq('<label for="user_cost">Total cost</label>') }
  end

  it_behaves_like "the default form builder", :label, :title, "A short title"
  it_behaves_like "the default form builder", :label, :privacy, "Public Post", value: "public"

  context "when calling #label with a block" do
    let(:object) { TestModel.new }
    let(:default_form_builder) { form_with(object, builder: ActionView::Helpers::FormBuilder) }
    let(:helpers) { ApplicationController.helpers }

    it "renders the block argument as the translation" do
      label_block = proc { |translation| helpers.content_tag(:span, translation, class: "cost_label") }

      expect(form.label(:cost, &label_block)).to eq(default_form_builder.label(:cost, &label_block))
    end

    it "interpolates the block argument as the translation" do
      label_block = proc { |builder| "<em>#{ERB::Util.h(builder)}</em>".html_safe }

      expect(form.label(:cost, &label_block)).to eq(default_form_builder.label(:cost, &label_block))
    end

    it "exposes the translation and object to the block" do
      label_block = proc do |builder|
        helpers.content_tag(:span, builder.translation,
                            class: ["cost_label", ("error_label" if builder.object.errors.include?(:cost))])
      end

      expect(form.label(:cost, &label_block)).to eq(default_form_builder.label(:cost, &label_block))
    end

    it "translates with the tag value" do
      label_block = proc(&:translation)

      expect(form.label(:privacy, value: "public", &label_block))
        .to eq(default_form_builder.label(:privacy, value: "public", &label_block))
    end

    it "translates with a string tag value key" do
      label_block = proc(&:translation)

      expect(form.label(:privacy, { "value" => "public" }, &label_block))
        .to eq(default_form_builder.label(:privacy, { "value" => "public" }, &label_block))
    end

    it "renders a block without argument" do
      label_block = proc { 'Accept <a href="/terms">Terms</a>.'.html_safe }

      expect(form.label(:terms, &label_block)).to eq(default_form_builder.label(:terms, &label_block))
    end
  end

  it_behaves_like "the default form builder", :month_field, :birthday_month
  it_behaves_like "the default form builder", :number_field, :age
  it_behaves_like "the default form builder", :password_field, :password
  it_behaves_like "the default form builder", :phone_field, :phone
  it_behaves_like "the default form builder", :telephone_field, :phone
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

  context "when calling #error_message and #hint" do
    let(:object) { Author.new.tap { |author| author.errors.add(:name_with_initial, "is missing") } }
    # The builder's default options, as form_with sets some
    let(:form) do
      form_with(object, index: 1, namespace: "admin", skip_default_ids: true, allow_method_names_outside_object: true)
    end

    it "renders the error messages, without the builder's options as attributes" do
      expect(form.error_message(:name_with_initial, class: "error")).to eq('<div class="error">Is missing</div>')
    end

    it "renders the hint, without the builder's options as attributes" do
      expect(form.hint(:name_with_initial, "Initial included", class: "hint"))
        .to eq('<div class="hint">Initial included</div>')
    end
  end

  context "when calling #select with a block" do
    let(:options_block) { proc { '<option value="admin">Admin</option>'.html_safe } }
    let(:default_form_builder) { form_with(object, builder: ActionView::Helpers::FormBuilder) }

    it "renders the block as options, like the default form builder" do
      expect(form.select(:role, &options_block)).to eq(default_form_builder.select(:role, &options_block))
    end
  end

  it_behaves_like "the default form builder", :submit

  it_behaves_like "the default form builder", :text_area, :detail
  it_behaves_like "it renders a component", ViewComponent::Form::TextAreaComponent, :text_area, :detail
  it_behaves_like "the default form builder", :textarea, :detail
  it_behaves_like "it renders a component", ViewComponent::Form::TextAreaComponent, :textarea, :detail

  if defined?(ActionView::Helpers::Tags::ActionText)
    context "with ActionText" do
      let(:object) { TestModel.new }

      it_behaves_like "the default form builder", :rich_text_area, :foo,
                      data: { direct_upload_url: ".", blob_url_template: "." }
      it_behaves_like "it renders a component", ViewComponent::Form::RichTextAreaComponent, :rich_text_area, :foo,
                      data: { direct_upload_url: ".", blob_url_template: "." }
      it_behaves_like "the default form builder", :rich_textarea, :foo,
                      data: { direct_upload_url: ".", blob_url_template: "." }
      it_behaves_like "it renders a component", ViewComponent::Form::RichTextAreaComponent, :rich_textarea, :foo,
                      data: { direct_upload_url: ".", blob_url_template: "." }

      it "renders #rich_text_area with a block, like the default form builder" do
        default_form_builder = form_with(object, builder: ActionView::Helpers::FormBuilder)
        value_block = proc { "<p>Hello</p>".html_safe }
        data = { direct_upload_url: ".", blob_url_template: "." }

        expect(form.rich_text_area(:foo, data:, &value_block))
          .to eq(default_form_builder.rich_text_area(:foo, data:, &value_block))
      end

      context "when calling #rich_textarea with a block" do
        let(:default_form_builder) { form_with(object, builder: ActionView::Helpers::FormBuilder) }
        let(:data) { { direct_upload_url: ".", blob_url_template: "." } }
        let(:value_block) { proc { "<p>Default</p>".html_safe } }

        it "renders the block as the value of an empty field, like the default form builder" do
          expect(form.rich_textarea(:foo, data:, &value_block))
            .to eq(default_form_builder.rich_textarea(:foo, data:, &value_block))
        end

        it "keeps the saved value over the block, like the default form builder" do
          object.foo = "<p>Saved</p>"

          expect(form.rich_textarea(:foo, data:, &value_block))
            .to eq(default_form_builder.rich_textarea(:foo, data:, &value_block))
        end
      end
    end
  end

  context "when a builder overrides the original spelling of a helper" do
    let(:builder) do
      Class.new(described_class) do
        def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
          "check_box #{method} #{options[:class]} #{checked_value} #{unchecked_value}"
        end

        def text_area(method, options = {})
          "text_area #{method} #{options[:class]}"
        end

        def rich_text_area(method, options = {}, &block)
          "rich_text_area #{method} #{options[:class]} #{block&.call}"
        end
      end.new(object_name, object, template, {})
    end

    it "renders #checkbox with it" do
      expect(builder.checkbox(:terms, { class: "check" }, "yes", "no")).to eq("check_box terms check yes no")
    end

    it "renders #textarea with it" do
      expect(builder.textarea(:detail, class: "area")).to eq("text_area detail area")
    end

    if defined?(ActionView::Helpers::Tags::ActionText)
      it "renders #rich_textarea with it, block included" do
        expect(builder.rich_textarea(:bio, class: "rich") { "Hello" }).to eq("rich_text_area bio rich Hello")
      end
    end
  end

  it_behaves_like "the default form builder", :text_field, :name
  it_behaves_like "the default form builder", :time_field, :born_at
  it_behaves_like "the default form builder", :time_select, :average_lap
  it_behaves_like "the default form builder", :time_zone_select, :time_zone, nil, { include_blank: true }
  it_behaves_like "the default form builder", :url_field, :homepage
  it_behaves_like "the default form builder", :week_field, :birthday_week
  it_behaves_like "the default form builder", :weekday_select, :weekday, { include_blank: true }
  it_behaves_like "it renders a component", ViewComponent::Form::WeekdaySelectComponent, :weekday_select, :weekday,
                  { include_blank: true }

  describe "#render_component" do
    let(:builder) { CustomFormBuilder.new(object_name, object, template, options) }

    it "forwards keyword arguments to the component" do
      expect(builder.badge(:name, label: "New")).to eq('<span class="badge-name">New</span>')
    end
  end

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

  describe "#field_name" do
    it_behaves_like "the default form builder", :field_name, :first_name
    it_behaves_like "the default form builder", :field_name, :tag_ids, multiple: true

    it "names the field with the builder's index" do
      expect(form_with(object, index: 3).field_name(:first_name)).to eq("user[3][first_name]")
    end
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
