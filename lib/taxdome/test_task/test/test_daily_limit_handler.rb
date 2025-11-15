require "minitest/autorun"
require_relative "../src/state_store"
require_relative "../src/request"
require_relative "../src/base_handler"
require_relative "../src/handlers/daily_limit_handler"

class TestDailyLimitHandler < Minitest::Test
  def setup
    @state = StateStore.new
    @handler = DailyLimitHandler.new(nil, state: @state)
  end

  def request_json(id, amount="$1000", time="2000-01-01T00:00:00Z")
    %Q({"id":"#{id}","customer_id":"10","load_amount":"#{amount}","time":"#{time}"})
  end

  def test_allows_within_limit
    req = Request.new(request_json(1, "$1000"))
    out = @handler.call(req)
    assert_equal true, out["accepted"]
  end

  def test_reject_when_exceeds
    @state.add_daily(10, Time.parse("2000-01-01T00:00:00Z"), 4800)
    req = Request.new(request_json(2, "$300"))
    out = @handler.call(req)
    assert_equal false, out["accepted"]
  end
end
