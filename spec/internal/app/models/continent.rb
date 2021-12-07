# frozen_string_literal: true

class Continent < ActiveRecord::Base
  has_many :countries
  # attribs: id, name
end
