# frozen_string_literal: true

source "https://rubygems.org"

gem "appraisal", require: false
gem "capybara", require: false
gem "combustion"
gem "generator_spec"
gem "rails"
gem "rake", "~> 13.0"
gem "rspec", "~> 3.0", require: false
gem "rspec-html-matchers"
gem "rspec-rails", require: false
gem "rubocop", require: false
gem "rubocop-performance", require: false
gem "rubocop-rspec", require: false
gem "simplecov", require: false, group: :test
gem "sqlite3"

group :development do
  gem "view_component"

  gem "lookbook", ">= 2.0.0.beta.3"
  gem "puma"

  # Optional dependencies of Lookbook 2.0
  gem "actioncable"
  gem "listen"
end

# Specify your gem's dependencies in view_component-form.gemspec
gemspec
