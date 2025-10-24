# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in view_component-form.gemspec
gemspec

group :development, :test do
  gem "appraisal", "~> 2"
  gem "appraisal-run", "~> 1.0"
  gem "capybara", require: false
  gem "combustion", "~> 1.3.7"
  gem "rspec", "~> 3.0", require: false
  gem "rspec-html-matchers"
  gem "rspec-rails", require: false
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rspec", require: false
  gem "simplecov", require: false, group: :test
end

gem "generator_spec"
gem "rails"
gem "rake", "~> 13.0"
gem "sqlite3", "~> 2.1", group: :test

# Temporarilly fi for "uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger" error
gem "concurrent-ruby", "= 1.3.4"
