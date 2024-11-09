# frozen_string_literal: true

require_relative "lib/view_component/form/version"

Gem::Specification.new do |spec|
  spec.name        = "view_component-form"
  spec.version     = ViewComponent::Form::VERSION
  spec.authors     = ["Pantographe"]
  spec.email       = ["oss@pantographe.studio"]

  spec.summary       = "Rails FormBuilder for ViewComponent"
  spec.description   = "Rails FormBuilder for ViewComponent"
  spec.homepage      = "https://github.com/pantographe/view_component-form"
  spec.license       = "MIT"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "changelog_uri" => "https://github.com/pantographe/view_component-form/blob/master/CHANGELOG.md",
    "source_code_uri" => spec.homepage,
    "bug_tracker_uri" => "https://github.com/pantographe/view_component-form/issues",
    "rubygems_mfa_required" => "true"
  }

  spec.files         = Dir["CHANGELOG.md", "LICENSE.txt", "README.md", "app/**/*", "lib/**/*"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  spec.add_dependency "actionview", [">= 6.1.0", "< 8.1"]
  spec.add_dependency "activesupport", [">= 6.1.0", "< 8.1"]
  spec.add_dependency "view_component", [">= 2.34.0", "< 4.0"]
  spec.add_dependency "zeitwerk", ["~> 2.5"]
end
