# frozen_string_literal: true

class HiddenFieldTest < ActiveRecord::Base
  attribute :pass_confirm, :boolean
  attribute :tag_list, :string
  attribute :token, :string
end
