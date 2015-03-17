require "minitest/autorun"
require_relative "../lib/summary_holdings.rb"

class TestSummaryHoldings < Minitest::Test

  def setup
    subscription_fields = File.open("data/summary_holdings_input.txt").read
    @subscription_fields = subscription_fields.lines.map(&:chomp)
  end

  def test_basic_summary_holdings
    summary_holdings_statement = SummaryHoldings.parse(@subscription_fields)
    assert_equal "1997-2011", summary_holdings_statement
  end

  # create test cases for all possibilities

end
