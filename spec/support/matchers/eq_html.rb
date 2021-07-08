# frozen_string_literal: true

module ComponentMatchers
  class EqHtml
    attr_reader :actual, :expected

    def initialize(expected)
      @expected = expected
      @actual = nil
      @invalid_response = nil
    end

    def matches?(html_fragment)
      html_fragment = html_fragment.to_html if html_fragment.is_a? Nokogiri::HTML::DocumentFragment

      @actual = html_fragment

      @actual.include?(expected_formatted)
    end

    def failure_message
      "expected that HTML fragment contain #{expected_formatted}"
    end

    def failure_message_when_negated
      "expected that HTML fragment not contain #{expected_formatted}"
    end

    def description
      "has HTML containing #{expected_formatted}"
    end

    def diffable?
      false
    end

    private

    def expected_formatted
      expected.chomp
    end
  end

  def eq_html(html)
    EqHtml.new(html)
  end
end

RSpec.configure do |config|
  config.include ComponentMatchers, type: :component
end
