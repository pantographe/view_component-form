# frozen_string_literal: true

ActiveRecord::Schema.define do
  # Set up any tables you need to exist for your test suite that don't belong
  # in migrations.
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
end
