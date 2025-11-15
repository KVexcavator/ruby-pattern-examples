require "minitest/autorun"
require "time"
require_relative "../src/state_store"
require_relative "../src/request"
require_relative "../src/base_handler"
Dir["../src/handlers/*.rb"].each { |f| require_relative f }
require_relative "../src/chain_builder"

class TestChainIntegration < Minitest::Test
  def setup
    @state = StateStore.new
    @chain = ChainBuilder.build(@state)
  end

  def make_request(id:, customer: 7, amount:, time: "2020-01-01T10:00:00Z")
    json = %Q({
      "id":"#{id}",
      "customer_id":"#{customer}",
      "load_amount":"$#{amount}",
      "time":"#{time}"
    })
    Request.new(json)
  end

  def test_happy_flow
    r1 = @chain.call(make_request(id: 10, amount: 100))
    r2 = @chain.call(make_request(id: 11, amount: 200))
    assert_equal true, r1["accepted"]
    assert_equal true, r2["accepted"]
  end

  def test_daily_limit_trigger
    @chain.call(make_request(id: 1, amount: 4900))
    out = @chain.call(make_request(id: 2, amount: 500))
    assert_equal false, out["accepted"]
  end

  def test_weekly_limit_trigger
    t = Time.parse("2020-01-01T10:00:00Z")
    @state.add_weekly(7, t, 19_950)
    out = @chain.call(make_request(id: 3, amount: 100))
    assert_equal false, out["accepted"]
  end

  def test_prime_rule_integration
    out1 = @chain.call(make_request(id: 3, amount: 100))   # prime → accepted
    out2 = @chain.call(make_request(id: 5, amount: 50))    # prime again → rejected
    assert_equal true, out1["accepted"]
    assert_equal false, out2["accepted"]
  end

  def test_daily_count_limit
    3.times { @chain.call(make_request(id: rand(100..999), amount: 10)) }
    out = @chain.call(make_request(id: 4, amount: 10))
    assert_equal false, out["accepted"]
  end

  def test_monday_multiplier
    # monday
    monday_time = "2025-11-17T00:00:00Z"
    req1 = make_request(id: 1, customer: 1, amount: 2000, time: monday_time)
    out1 = @chain.call(req1)
    assert_equal true, out1["accepted"]

    req2 = make_request(id: 2, customer: 1, amount: 2000, time: monday_time)
    out2 = @chain.call(req2)
    # after multiplying the amount > limit
    assert_equal false, out2["accepted"]
  end
end
