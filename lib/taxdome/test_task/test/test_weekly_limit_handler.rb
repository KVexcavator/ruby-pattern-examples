require "minitest/autorun"
require "time"
require_relative "../src/state_store"
require_relative "../src/request"
require_relative "../src/base_handler"
require_relative "../src/handlers/weekly_limit_handler"

class TestWeeklyLimitHandler < Minitest::Test
  def setup
    @state = StateStore.new
    @handler = WeeklyLimitHandler.new(nil, state: @state)
  end

  def test_allows_within_limit
    json = %Q({"id":"1","customer_id":"42","load_amount":"$10000","time":"2020-01-03T00:00:00Z"})
    req = Request.new(json)
    out = @handler.call(req)
    assert_equal true, out["accepted"]
  end

  def test_reject_when_exceeds
    t = Time.parse("2020-01-03T00:00:00Z")
    @state.add_weekly(42, t, 19900)

    json = %Q({"id":"2","customer_id":"42","load_amount":"$200","time":"2020-01-03T01:00:00Z"})
    req = Request.new(json)
    out = @handler.call(req)
    assert_equal false, out["accepted"]
  end
end
