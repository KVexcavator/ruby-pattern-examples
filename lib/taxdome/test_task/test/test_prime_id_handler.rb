require "minitest/autorun"
require_relative "../src/state_store"
require_relative "../src/request"
require_relative "../src/base_handler"
require_relative "../src/handlers/prime_id_handler"

class TestPrimeIDHandler < Minitest::Test
  def setup
    @state = StateStore.new
    @handler = PrimeIDHandler.new(nil, state: @state)
  end

  def req(id, amount)
    json = %Q({
      "id":"#{id}",
      "customer_id":"1",
      "load_amount":"$#{amount}",
      "time":"2020-01-01T00:00:00Z"
    })
    Request.new(json)
  end

  def test_prime_allowed_first_time
    out = @handler.call(req(3, 100))
    assert_equal true, out["accepted"]
  end

  def test_prime_rejected_second_time_same_day
    @state.set_prime_used(Time.parse("2020-01-01T00:00:00Z"))
    out = @handler.call(req(3, 100))
    assert_equal false, out["accepted"]
  end

  def test_prime_rejected_if_amount_too_large
    out = @handler.call(req(3, 10000)) # > 9999
    assert_equal false, out["accepted"]
  end

  def test_non_prime_ids_pass_freely
    out = @handler.call(req(10, 500))
    assert_equal true, out["accepted"]
  end
end
