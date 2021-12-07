# frozen_string_literal: true

class City < ActiveRecord::Base
  belongs_to :country
  # attribs: id, name, country_id
end
