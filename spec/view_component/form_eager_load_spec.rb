# frozen_string_literal: true

require "open3"
require "rbconfig"

RSpec.describe ViewComponent::Form do
  it "does not load the controller test case during eager loading" do
    script = <<~RUBY
      require "rails"
      require "action_controller"
      require "view_component"
      require "view_component/form"

      Zeitwerk::Loader.eager_load_all

      puts ActionController::Live.instance_method(:new_controller_thread).source_location.first
    RUBY

    output, status = run_in_clean_process(script)

    expect(status).to be_success, output
    expect(output).to end_with("action_controller/metal/live.rb\n")
  end

  it "allows explicit requires of the test helpers" do
    script = <<~RUBY
      require "rails"
      require "action_controller"
      require "view_component"
      require "view_component/form"
      require "view_component/form/test_helpers"

      puts ViewComponent::Form::TestHelpers.name
    RUBY

    output, status = run_in_clean_process(script)

    expect(status).to be_success, output
    expect(output).to end_with("ViewComponent::Form::TestHelpers\n")
  end

  it "autoloads the test helpers" do
    script = <<~RUBY
      require "rails"
      require "action_controller"
      require "view_component"
      require "view_component/form"

      puts ViewComponent::Form::TestHelpers.name
    RUBY

    output, status = run_in_clean_process(script)

    expect(status).to be_success, output
    expect(output).to end_with("ViewComponent::Form::TestHelpers\n")
  end

  def run_in_clean_process(script)
    Open3.capture2e(
      { "RUBYOPT" => "-rbundler/setup" },
      RbConfig.ruby,
      "-e",
      script,
      chdir: File.expand_path("../..", __dir__)
    )
  end
end
