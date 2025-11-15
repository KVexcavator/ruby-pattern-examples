require "minitest/autorun"
require_relative "../src/state_store"
require_relative "../src/request"
require_relative "../src/base_handler"
require_relative "../src/handlers/monday_penalty_handler"

class TestMondayPenaltyHandler < Minitest::Test
  def setup
    @state = StateStore.new
    @handler = MondayPenaltyHandler.new(nil, state: @state)
  end

  def test_always_allows
    json = %Q({"id":"1","customer_id":"1","load_amount":"$50","time":"2020-01-06T00:00:00Z"}) # Monday
    req = Request.new(json)
    out = @handler.call(req)
    assert_equal true, out["accepted"]
  end
  
end
