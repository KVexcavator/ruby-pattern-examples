class StateStore
  def initialize
    @daily_amount = Hash.new { |h, k| h[k] = 0.0 }
    @weekly_amount = Hash.new { |h, k| h[k] = 0.0 }
    @daily_count = Hash.new { |h, k| h[k] = 0 }
    @prime_used = Hash.new { |h, k| h[k] = false }
  end

  def day_key(time) = time.strftime("%Y-%m-%d")
  # ISO year-week number, for example: 2024-45
  def week_key(time) = time.strftime("%G-%V")

  def add_daily(customer_id, time, amount)
    @daily_amount[[customer_id, day_key(time)]] += amount
  end

  def add_weekly(customer_id, time, amount)
    @weekly_amount[[customer_id, week_key(time)]] += amount
  end

  def add_count(customer_id, time)
    @daily_count[[customer_id, day_key(time)]] += 1
  end

  def daily_amount(customer_id, time)
    @daily_amount[[customer_id, day_key(time)]]
  end

  def weekly_amount(customer_id, time)
    @weekly_amount[[customer_id, week_key(time)]]
  end

  def daily_count(customer_id, time)
    @daily_count[[customer_id, day_key(time)]]
  end

  def prime_used?(time)
    @prime_used[day_key(time)]
  end

  def set_prime_used(time)
    @prime_used[day_key(time)] = true
  end
end
