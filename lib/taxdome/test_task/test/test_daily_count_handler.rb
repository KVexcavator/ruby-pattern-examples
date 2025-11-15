require "minitest/autorun"
require "time"
require_relative "../src/state_store"
require_relative "../src/request"
require_relative "../src/base_handler"
require_relative "../src/handlers/daily_count_handler"

class TestDailyCountHandler < Minitest::Test
  def setup
    @state = StateStore.new
    @handler = DailyCountHandler.new(nil, state: @state)
    @time = Time.parse("2020-12-12T00:00:00Z")
  end

  def request_json(id)
    %Q({"id":"#{id}","customer_id":"55","load_amount":"$10","time":"2020-12-12T00:00:00Z"})
  end

  def test_allows_first_three
    3.times do |i|
      req = Request.new(request_json(i+1))
      out = @handler.call(req)
      assert_equal true, out["accepted"]
    end
  end

  def test_reject_fourth
    3.times { @state.add_count(55, @time) }

    req = Request.new(request_json(99))
    out = @handler.call(req)

    assert_equal false, out["accepted"]
  end
end
