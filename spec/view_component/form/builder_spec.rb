# frozen_string_literal: true

RSpec.describe ViewComponent::Form::Builder, type: :builder do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  context "with standard helpers" do
    it { expect(form).to respond_to(:button).with(0..2).arguments }
    it { expect(form).to respond_to(:check_box).with(1..4).arguments }
    it { expect(form).to respond_to(:collection_check_boxes).with(4..6).arguments }
    it { expect(form).to respond_to(:collection_radio_buttons).with(4..6).arguments }
    it { expect(form).to respond_to(:collection_select).with(4..6).arguments }
    it { expect(form).to respond_to(:color_field).with(1..2).arguments }
    it { expect(form).to respond_to(:date_field).with(1..2).arguments }
    it { expect(form).to respond_to(:date_select).with(1..3).arguments }
    it { expect(form).to respond_to(:datetime_field).with(1..2).arguments }
    it { expect(form).to respond_to(:datetime_local_field).with(1..2).arguments }
    it { expect(form).to respond_to(:datetime_select).with(1..3).arguments }
    it { expect(form).to respond_to(:email_field).with(1..2).arguments }
    it { expect(form).to respond_to(:fields).with(0..1).arguments }
    it { expect(form).to respond_to(:fields_for).with(1..3).arguments }
    it { expect(form).to respond_to(:file_field).with(1..2).arguments }
    it { expect(form).to respond_to(:grouped_collection_select) }
    it { expect(form).to respond_to(:hidden_field).with(1..2).arguments }
    it { expect(form).to respond_to(:label).with(1..3).arguments }
    it { expect(form).to respond_to(:month_field).with(1..2).arguments }
    it { expect(form).to respond_to(:number_field).with(1..2).arguments }
    it { expect(form).to respond_to(:password_field).with(1..2).arguments }
    it { expect(form).to respond_to(:phone_field).with(1..2).arguments }
    it { expect(form).to respond_to(:radio_button).with(2..3).arguments }
    it { expect(form).to respond_to(:range_field).with(1..2).arguments }
    it { expect(form).to respond_to(:search_field).with(1..2).arguments }
    it { expect(form).to respond_to(:select).with(1..4).arguments }
    it { expect(form).to respond_to(:submit).with(0..2).arguments }
    it { expect(form).to respond_to(:telephone_field).with(1..2).arguments }
    it { expect(form).to respond_to(:rich_text_area).with(1..2).arguments }
    it { expect(form).to respond_to(:text_area).with(1..2).arguments }
    it { expect(form).to respond_to(:text_field).with(1..2).arguments }
    it { expect(form).to respond_to(:time_field).with(1..2).arguments }
    it { expect(form).to respond_to(:time_select).with(1..3).arguments }
    it { expect(form).to respond_to(:time_zone_select).with(1..3).arguments }
    it { expect(form).to respond_to(:url_field).with(1..2).arguments }
    it { expect(form).to respond_to(:week_field).with(1..2).arguments }
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
  end
end
