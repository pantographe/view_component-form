# frozen_string_literal: true

RSpec.shared_context "with translations" do
  let(:translations) { {} }

  around do |example|
    I18n.backend.store_translations(:en, translations)
    example.run
    I18n.backend.reload!
  end
end
