# frozen_string_literal: true

ActiveRecord::Schema.define do
  # Set up any tables you need to exist for your test suite that don't belong
  # in migrations.
  if ENV.fetch("VIEW_COMPONENT_FORM_USE_ACTIONTEXT", "false") == "true"
    create_table(:action_text_rich_texts, force: true) do |t|
      t.string :name
      t.text :body
      t.references :record, null: false, polymorphic: true, index: false
      t.timestamps
    end
  end

  create_table(:authors, force: true) do |t|
    t.string :name_with_initial
    t.timestamps
  end

  create_table(:people, force: true) do |t|
    t.string :name
    t.timestamps
  end

  create_table(:hidden_field_tests, force: true) do |t|
    t.boolean :pass_confirm
    t.string :token
    t.string :tag_list
    t.timestamps
  end

  create_table(:continents, force: true) do |t|
    t.string :name
    t.timestamps
  end

  create_table(:countries, force: true) do |t|
    t.string :name
    t.belongs_to :continent
    t.timestamps
  end

  create_table(:cities, force: true) do |t|
    t.belongs_to :country
    t.timestamps
  end

  create_table(:messages, force: true) do |t|
    t.timestamps
  end
end
