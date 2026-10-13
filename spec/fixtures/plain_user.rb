# frozen_string_literal: true

# Plain Ruby object, not implementing the ActiveModel API
PlainUser = Struct.new(:first_name, :last_name, :email, :city, keyword_init: true)
