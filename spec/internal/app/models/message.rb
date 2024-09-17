# frozen_string_literal: true

class Message < ActiveRecord::Base
  has_rich_text :content
end
