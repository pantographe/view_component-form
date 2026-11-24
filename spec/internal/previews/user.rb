# frozen_string_literal: true

# The model the previews' forms are built for
class User
  include ActiveModel::Model
  include ActiveModel::Attributes

  Role = Struct.new(:id, :name)
  Team = Struct.new(:name, :roles)

  ROLES = [Role.new(1, "Admin"), Role.new(2, "Editor"), Role.new(3, "Viewer")].freeze
  TEAMS = [Team.new("Staff", ROLES.first(2)), Team.new("Guests", ROLES.last(1))].freeze

  attribute :name, :string
  attribute :email, :string
  attribute :password, :string
  attribute :bio, :string
  attribute :website, :string
  attribute :phone, :string
  attribute :age, :integer
  attribute :volume, :integer
  attribute :favorite_color, :string
  attribute :birthday, :date
  attribute :wakes_up_at, :time
  attribute :last_seen_at, :datetime
  attribute :newsletter, :boolean
  attribute :role_id, :integer
  attribute :time_zone, :string
  attribute :country, :string
  attribute :day_off, :string
  attribute :avatar
  attribute :role_ids, default: -> { [] }

  validates :name, :email, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 18 }, allow_nil: true

  def self.invalid
    new(age: 12).tap(&:validate)
  end
end
