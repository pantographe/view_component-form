RSpec::Matchers.define :eq_html do |expected|
  match do |actual|
    actual == expected.chomp
  end

  failure_message do |actual|
    "expected: #{actual}\n     got: #{expected}"
  end

  failure_message_when_negated do |actual|
    "expected: HTML != #{actual}\n     got: #{expected}"
  end
end
