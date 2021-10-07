# frozen_string_literal: true

class Country < ActiveRecord::Base
  belongs_to :continent
  # attribs: id, name, continent_id
end
